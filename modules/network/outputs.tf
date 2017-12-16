output "ssh-key" {
  value = "${opc_compute_ssh_key.ssh-key.name}"
}
output "ip-network-name" {
  value = "${opc_compute_ip_network.kube-ip-network.name}"
}
output "access-control-list" {
  value = "${opc_compute_acl.access-control-list.name}"
}
