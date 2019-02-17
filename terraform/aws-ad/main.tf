# ---------------------------------------------------------------------------------------------------------------------
# THESE TEMPLATES REQUIRE TERRAFORM VERSION 0.8 AND ABOVE
# ---------------------------------------------------------------------------------------------------------------------

terraform {
  required_version = ">= 0.9.3"
}

resource "aws_directory_service_directory" "vibrato" {
  name     = "${var.domainName}"
  password = "${var.domainPassword}"
  size     = "Small"

  vpc_settings {
    vpc_id     = "${data.aws_vpc.default.id}"
    subnet_ids = ["${data.aws_subnet_ids.private.ids}"]
  }

  tags = "${var.tags}"
}

data "aws_vpc" "default" {
  tags    = "${var.vpc_tags}"
}

data "aws_subnet_ids" "private" {
  vpc_id = "${data.aws_vpc.default.id}"
  filter {
    name   = "tag:Name"
    values = "${var.subnet_tags}"
  }
}
