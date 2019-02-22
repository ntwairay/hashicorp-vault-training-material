# ---------------------------------------------------------------------------------------------------------------------
# THESE TEMPLATES REQUIRE TERRAFORM VERSION 0.8 AND ABOVE
# ---------------------------------------------------------------------------------------------------------------------

terraform {
  required_version = ">= 0.9.3"
}

provider "aws" {
  region = "${var.region}"
}

data "aws_route_table" "r1" {
  filter {
    name   = "${var.route_table_tag_name}"
    values = "${var.r1_tag_values}"
  }
}

data "aws_route_table" "r2" {
  filter {
    name   = "${var.route_table_tag_name}"
    values = "${var.r2_tag_values}"
  }
}

module "vpc_peering_route" {
  source                      = "../../modules/vpc-peering-route"
  vpc_private_route_table_ids =["${data.aws_route_table.r1.route_table_id}", "${data.aws_route_table.r2.route_table_id}" ]
  peer_cidr_block             = "${var.peer_cidr_block}"
  peer_connection_id          = "${data.terraform_remote_state.peer.vpc_peering_connection_id}"
}
