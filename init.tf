provider "opc" {
  user            = "${var.opc-user}"
  password        = "${var.opc-password}"
  identity_domain = "${var.identity-domain}"
  endpoint        = "${var.rest-end-point}"
}
