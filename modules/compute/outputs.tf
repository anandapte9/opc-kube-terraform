output ip-reservation {
   value = "${opc_compute_ip_address_reservation.ip-address-reservation.*.ip_address}"
}

output "compute-ip-address" {
  value = "${opc_compute_instance.compute-instance.*.ip_address}"
}
