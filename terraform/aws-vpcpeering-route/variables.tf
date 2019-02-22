variable "remote_state_aws_foundation_bucket" {
  default = ""
}

variable "route_table_tag_name" {
  default = "Name"
}

variable "r1_tag_values" {
  default = []
}

variable "r2_tag_values" {
  default = []
}

variable "peer_cidr_block" {
  default = ""
}

variable "bucket_key" {
  default = "vpcpeering"
}

variable "region" {
  default = ""
}
