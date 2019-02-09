# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# You must provide a value for each of these parameters.
# ---------------------------------------------------------------------------------------------------------------------

variable "available_cidr_ips" {
  description = "The total ip address/es can be generated within the CIDR"
  default = "14"
}

variable "cidr_ip" {
  description = "Write the PEM-encoded certificate public key to this path (e.g. /etc/tls/vault.crt.pem)."
  default = "10.1.1.1/28"
}
