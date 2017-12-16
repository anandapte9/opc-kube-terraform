module "network-infrastructure" {
	source              = "./modules/network"
	ip-address-prefix   = "${var.ip-address-prefix}"
	ssh_user            = "${var.ssh_user}"
	ssh_private_key     = "${var.ssh_private_key}"
	ssh_public_key      = "${var.ssh_public_key}"
}

module "master_instances" {
	source          	  = "./modules/compute"
	instance-count  	  = 1
	app-type        	  = "kube-master"
	ip-network      	  = "${module.network-infrastructure.ip-network-name}"
	ssh-key         	  = "${module.network-infrastructure.ssh-key}"
	ssh_user            = "${var.ssh_user}"
	ssh_private_key     = "${var.ssh_private_key}"
	access-control-list = "${module.network-infrastructure.access-control-list}"
	instance-shape      = "${var.instance-shape}"
	instance-image      = "${var.instance-image}"
}

module "node_instances" {
	source          	  = "./modules/compute"
	instance-count  	  = "${var.node-instance-count}"
	app-type        	  = "kube-node"
	ip-network      	  = "${module.network-infrastructure.ip-network-name}"
	ssh-key         	  = "${module.network-infrastructure.ssh-key}"
	ssh_user            = "${var.ssh_user}"
	ssh_private_key     = "${var.ssh_private_key}"
	access-control-list = "${module.network-infrastructure.access-control-list}"
	instance-shape      = "${var.instance-shape}"
	instance-image      = "${var.instance-image}"
}

module "kube-enable" {
	source          	  = "./modules/kube-cluster"
	ssh_user            = "${var.ssh_user}"
	ssh_private_key     = "${var.ssh_private_key}"
	instance-count  	  = "${var.node-instance-count}"
	master-ip-address   = ["${module.master_instances.ip-reservation}"]
	node-ip-address     = ["${module.node_instances.compute-ip-address}"]
}

output "master-public-ip" {
	value = ["${module.master_instances.ip-reservation}"]
}

output "node-public-ips" {
	value = ["${module.node_instances.ip-reservation}"]
}
