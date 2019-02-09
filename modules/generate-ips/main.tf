resource "null_resource" "cidr" {
  count = "${var.available_cidr_ips}"

  triggers {
    ip_addresses = "${cidrhost(var.cidr_ip, count.index)}"
  }
}
