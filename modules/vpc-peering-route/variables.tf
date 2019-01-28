variable "vpc_private_route_table_ids" {
  type = "list"
  description = "The group of route tables need to route to the vpc peering subnet"
}

variable "peer_cidr_block" {
  description = "The ip address range of the network"
}

variable "peer_connection_id" {
  description = "The peer connection id"
}
