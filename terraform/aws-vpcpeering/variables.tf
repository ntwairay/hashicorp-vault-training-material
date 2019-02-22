variable "peer_remote_state_aws_foundation_bucket" {
  default = ""
}

variable "peer_region" {
  default = "us-west-2"
}

variable "peer_owner_id" {
  default = ""
}

variable "peer_cidr_block" {
  default = ""
}

variable "vpc_tags" {
  description = "Tags used to find a vpc for building resources in"
  type        = "map"
  default     = {}
}

variable "peer_bucket_key" {
  default = "vpc"
}

variable "region" {
  default = ""
}
