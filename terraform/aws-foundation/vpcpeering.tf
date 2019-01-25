provider "aws" {
  alias  = "peer"
  region = "us-west-2"

  # Accepter's credentials.
}

data "aws_caller_identity" "peer" {
  provider = "aws.peer"
}

# Requester's side of the connection.
resource "aws_vpc_peering_connection" "peer" {
  count         =  "${var.create_vpc_peering ? 1 : 0}"
  vpc_id        = "vpc-091ddf575789411ae"
  peer_vpc_id   = "vpc-094245701a99ea05f"
  peer_owner_id = "578612111946"
  peer_region   = "us-west-2"
  auto_accept   = false

  tags = {
    Side = "Requester"
  }
}

# Accepter's side of the connection.
resource "aws_vpc_peering_connection_accepter" "peer" {
  count                     = "${var.create_vpc_peering ? 1 : 0}"
  provider                  = "aws.peer"
  vpc_peering_connection_id = "${aws_vpc_peering_connection.peer.id}"
  auto_accept               = true

  tags = {
    Side = "Accepter"
  }
}

resource "aws_route" "r" {
  count                     = "${length(module.vpc.private_route_table_ids)}"
  route_table_id            = "${module.vpc.private_route_table_ids[count.index]}"
  destination_cidr_block    = "${var.destination_cidr_block}"
  vpc_peering_connection_id = "${var.create_vpc_peering ? aws_vpc_peering_connection.peer.id : var.vpc_peering_connection_id }"
}
