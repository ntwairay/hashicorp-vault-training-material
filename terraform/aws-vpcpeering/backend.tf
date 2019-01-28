terraform {
  backend "s3" {
    bucket = ""
    key    = "vpcpeering"
    region = "us-west-1"
    encrypt = true
  }
}

data "terraform_remote_state" "peer" {
  backend = "s3"
  config {
    bucket = "${var.peer_remote_state_aws_foundation_bucket}"
    key    = "${var.peer_bucket_key}"
    region = "us-west-1"
  }
}
