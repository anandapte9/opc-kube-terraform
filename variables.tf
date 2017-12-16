# Initialization Variables

variable "opc-user" {}
variable "opc-password" {}
variable "identity-domain" {}
variable "rest-end-point" {}

# SSH variables

variable ssh_user {
  description = "User account for ssh access to the image"
}

variable ssh_private_key {
  description = "File location of the ssh public key"
}

variable ssh_public_key {
  description = "File location of the ssh public key"
}

variable ssh-key { default = "" }
variable ip-network { default = "" }
variable access-control-list { default = "" }

# COUNT / LOOP variables

//variable "instance-count" {}
variable "master-instance-count" {}
variable "node-instance-count" {}

# Intance specific variables

variable "instance-shape" {}
variable "app-type" { default = "" }
variable "instance-image" {}

variable "ip-address-prefix" {}
variable "pod-network-cidr" {}
