# ---------------------------------------------------------------------------------------------------------------------
# THESE TEMPLATES REQUIRE TERRAFORM VERSION 0.8 AND ABOVE
# ---------------------------------------------------------------------------------------------------------------------

terraform {
  required_version = ">= 0.9.3"
}

provider "aws" {
  region = "${var.region}"
}

data "aws_vpc" "default" {
  tags = "${var.vpc_tags}"
}

module "vpc_peering" {
  source          = "../../modules/vpc-peering"
  vpc_id          = "${data.aws_vpc.default.id}"
  peer_vpc_id     = "${data.terraform_remote_state.peer.vpc_id}"
  peer_owner_id   = "${var.peer_owner_id}"
  peer_region     = "${var.peer_region}"
  peer_cidr_block = "${var.peer_cidr_block}"
}
