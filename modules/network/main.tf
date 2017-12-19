resource "opc_compute_ssh_key" "ssh-key" {
  name               = "kubernetes-key"
  key                = "${file("${path.root}/keys/${var.ssh_public_key}")}"
  enabled            = true
}

resource "opc_compute_ip_network" "kube-ip-network" {
	name 			         = "ip-network-kubernetes"
	description 	     = "ip-network-kubernetes"
	ip_address_prefix  = "${var.ip-address-prefix}"
}

resource "opc_compute_acl" "access-control-list" {
  name               = "access-control-list"
}

resource "opc_compute_ip_address_prefix_set" "ip-address-perfix" {
  name               = "ip-address-prefix"
  prefixes           = ["${var.ip-address-prefix}"]
}

resource "opc_compute_security_rule" "inbound-security-rule" {
  name               = "Allow-ssh-ingress"
  flow_direction     = "ingress"
  acl                = "${opc_compute_acl.access-control-list.name}"
  security_protocols = ["${opc_compute_security_protocol.inbound-protocols.name}"]
}

resource "opc_compute_security_rule" "egress" {
  name               = "Allow-all-egress"
  flow_direction     = "egress"
  acl                = "${opc_compute_acl.access-control-list.name}"
  security_protocols = ["${opc_compute_security_protocol.all.name}"]
}

resource "opc_compute_security_rule" "all-within-ip-network" {
  name                    = "all-within-ip-network"
  flow_direction          = "ingress"
  acl                     = "${opc_compute_acl.access-control-list.name}"
  security_protocols      = ["${opc_compute_security_protocol.all.name}"]
  src_ip_address_prefixes = ["${opc_compute_ip_address_prefix_set.ip-address-perfix.name}"]
  dst_ip_address_prefixes = ["${opc_compute_ip_address_prefix_set.ip-address-perfix.name}"]
}

resource "opc_compute_security_protocol" "all" {
  name        = "all"
  ip_protocol = "all"
}

resource "opc_compute_security_protocol" "inbound-protocols" {
  name        = "ssh"
  dst_ports   = ["22","80","8080"]
  ip_protocol = "tcp"
}
