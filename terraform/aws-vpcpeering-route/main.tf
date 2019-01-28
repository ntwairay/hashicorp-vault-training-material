# ---------------------------------------------------------------------------------------------------------------------
# THESE TEMPLATES REQUIRE TERRAFORM VERSION 0.8 AND ABOVE
# ---------------------------------------------------------------------------------------------------------------------

terraform {
  required_version = ">= 0.9.3"
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
  # When using these modules in your own templates, you will need to use a Git URL with a ref attribute that pins you
  # to a specific version of the modules, such as the following example:
  # source = "github.com/hashicorp/terraform-aws-consul.git/modules/vault-cluster?ref=v0.0.1"
  source                      = "../../modules/vpc-peering-route"
  vpc_private_route_table_ids =["${data.aws_route_table.r1.route_table_id}", "${data.aws_route_table.r2.route_table_id}" ]
  peer_cidr_block             = "${var.peer_cidr_block}"
  peer_connection_id          = "${data.terraform_remote_state.peer.vpc_peering_connection_id}"
}
