resource "opc_compute_ip_address_reservation" "ip-address-reservation" {
  count 		          = "${var.instance-count}"
  name                = "${format("%s-%s-%d", var.app-type, "ip-address-reservation", count.index + 1 )}"
  ip_address_pool     = "public-ippool"
}

resource "opc_compute_vnic_set" "virtual-nic-set" {
  count 	            = "${var.instance-count}"
  name                = "${format("%s-%s-%d", var.app-type, "virtual-nic-set", count.index + 1 )}"
  applied_acls        = ["${var.access-control-list}"]
  virtual_nics        = ["${format("%s-%s-%d-%s", var.app-type, "server", count.index + 1, "eth0" )}" ]
}

resource "opc_compute_instance" "compute-instance" {
  count               = "${var.instance-count}"
  name        	      = "${format("%s-%s-%d", var.app-type, "instance", count.index + 1 )}"
  hostname            = "${format("%s-%s-%d", var.app-type, "instance", count.index + 1 )}"
  label               = "${format("%s-%s-%d", var.app-type, "instance", count.index + 1 )}"
  shape               = "${var.instance-shape}"
  image_list          = "${var.instance-image}"

  networking_info {
    index             = 0
    ip_network        = "${var.ip-network}"
    vnic              = "${format("%s-%s-%d-%s", var.app-type, "server", count.index + 1, "eth0" )}"
    vnic_sets         = ["${element(opc_compute_vnic_set.virtual-nic-set.*.name, count.index)}"]
    nat               = ["${element(opc_compute_ip_address_reservation.ip-address-reservation.*.name, count.index)}"]
  }

  ssh_keys            = ["${var.ssh-key}"]
  instance_attributes = "${data.template_file.kube-userdata.rendered}"

}

resource "null_resource" "instance-init" {
  count          = "${var.instance-count}"
  depends_on     = ["opc_compute_instance.compute-instance"]

  provisioner "local-exec" {
    command      = "sleep 300"
  }

  connection {
     agent       = false
     timeout     = "10m"
     host        = "${element(opc_compute_ip_address_reservation.ip-address-reservation.*.ip_address, count.index)}"
     user        = "${var.ssh_user}"
     type        = "ssh"
     private_key = "${file("${path.root}/keys/${var.ssh_private_key}")}"
   }

   provisioner "file" {
    source = "${var.app-type == "kube-master" && count.index == 0 ? "${path.module}/bootstrap/kube-init-master.sh" : "${path.module}/bootstrap/kube-init-node.sh" }"
    destination = "/home/opc/kube-init.sh"
   }

   provisioner "remote-exec" {
    inline = [
       "chmod +x /home/opc/kube-init.sh",
       "cd /home/opc",
       "./kube-init.sh",
    ]
   }
}
