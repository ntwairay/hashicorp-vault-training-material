# ---------------------------------------------------------------------------------------------------------------------
# THESE TEMPLATES REQUIRE TERRAFORM VERSION 0.8 AND ABOVE
# ---------------------------------------------------------------------------------------------------------------------

terraform {
  required_version = ">= 0.9.3"
}

resource "aws_route" "routetable" {
  count                     = "${length(var.vpc_private_route_table_ids)}"
  route_table_id            = "${var.vpc_private_route_table_ids[count.index]}"
  destination_cidr_block    = "${var.peer_cidr_block}"
  vpc_peering_connection_id = "${var.peer_connection_id}"
}
