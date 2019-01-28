variable "vpc_id" {
  description = "The primary vpc id"
}

variable "peer_vpc_id" {
  description = "The peer vpc id"
}

variable "peer_owner_id" {
  description = "The owner id of peer vpc"
}

variable "peer_region" {
  description = "The peer region"
}

variable "peer_cidr_block" {
  description = "The ip address range of the network"
}
