ca_public_key_file_path = "../../packer/vault-consul-ami/tls/ca.crt.pem"
public_key_file_path    = "../../packer/vault-consul-ami/tls/vault.crt.pem"
private_key_file_path   = "../../packer/vault-consul-ami/tls/vault.key.pem"
owner                   = "ray"
organization_name       = "vibrato"
ca_common_name          = "localhost"
common_name             = "localhost"
dns_names               = ["*.vault.net","localhost","*.consul.net","*.vault.com","*.consul.com"]
validity_period_hours   = "1000"
available_cidr_ips      = "14"
cidr_ranges             = ["10.1.1.1/28","10.1.2.1/28","10.2.1.1/28","10.2.2.1/28"]
