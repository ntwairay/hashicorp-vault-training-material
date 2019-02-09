module "vault_private-tls-cert" {
  source                  = "hashicorp/vault/aws//modules/private-tls-cert"
  version                 = "0.0.4"
  ca_public_key_file_path = "${var.ca_public_key_file_path}"
  public_key_file_path    = "${var.public_key_file_path}"
  private_key_file_path   = "${var.private_key_file_path}"
  owner                   = "${var.owner}"
  organization_name       = "${var.organization_name}"
  ca_common_name          = "${var.ca_common_name}"
  common_name             = "${var.common_name}"
  dns_names               = "${var.dns_names}"
  ip_addresses            = "${concat(module.cidr_1.ip_addresses, module.cidr_2.ip_addresses, module.cidr_3.ip_addresses, module.cidr_4.ip_addresses)}"
  validity_period_hours   = "${var.validity_period_hours}"
}


module "cidr_1" {
  source              = "../../modules/generate-ips"
  available_cidr_ips  = "${var.available_cidr_ips}"
  cidr_ip             = "${var.cidr_ranges[0]}"
}

module "cidr_2" {
  source              = "../../modules/generate-ips"
  available_cidr_ips  = "${var.available_cidr_ips}"
  cidr_ip             = "${var.cidr_ranges[1]}"
}

module "cidr_3" {
  source              = "../../modules/generate-ips"
  available_cidr_ips  = "${var.available_cidr_ips}"
  cidr_ip             = "${var.cidr_ranges[2]}"
}

module "cidr_4" {
  source              = "../../modules/generate-ips"
  available_cidr_ips  = "${var.available_cidr_ips}"
  cidr_ip             = "${var.cidr_ranges[3]}"
}
