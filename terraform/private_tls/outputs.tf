output "ca_public_key_file_path" {
  value = "${module.vault_private-tls-cert.ca_public_key_file_path}"
}

output "public_key_file_path" {
  value = "${module.vault_private-tls-cert.public_key_file_path}"
}

output "private_key_file_path" {
  value = "${module.vault_private-tls-cert.private_key_file_path}"
}
