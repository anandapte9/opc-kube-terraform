resource "null_resource" "kube-enable" {
  count          = "${var.instance-count}"

  provisioner "local-exec" {
    command      = "sleep 60"
  }

  connection {
     agent       = false
     timeout     = "10m"
     host        = "${var.master-ip-address[0]}"
     user        = "${var.ssh_user}"
     type        = "ssh"
     private_key = "${file("${path.root}/keys/${var.ssh_private_key}")}"
   }

   provisioner "file" {
    source = "${path.root}/keys/${var.ssh_private_key}"
    destination = "/home/opc/kube_key"
   }

   provisioner "remote-exec" {
    inline = [
       "chmod 600 /home/opc/kube_key",
       "cd /home/opc",
       "command=`grep \"kubeadm join\" *.log`",
       "ssh -i kube_key -o 'StrictHostKeyChecking no' opc@${element(var.node-ip-address, count.index)} \"sudo $command\""
    ]
   }
}
