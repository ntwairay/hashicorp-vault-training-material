output "ip_addresses" {
  value = "${null_resource.cidr.*.triggers.ip_addresses}"
}
