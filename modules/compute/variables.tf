variable ssh_user {}
variable ssh_private_key {}

variable ssh-key { default = "" }
variable ip-network { default = "" }
variable access-control-list { default = "" }

# COUNT / LOOP variables

variable "instance-count" {}
variable "app-type" {}

# Intance specific variables

variable "instance-shape" {}
variable instance-image {}
