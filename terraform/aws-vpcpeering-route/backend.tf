terraform {
  backend "s3" {
    bucket = "hashicorp-vibrato"
    key    = ""
    region = "us-west-1"
    encrypt = true
  }
}

data "terraform_remote_state" "peer" {
  backend = "s3"
  config {
    bucket = "${var.remote_state_aws_foundation_bucket}"
    key    = "${var.bucket_key}"
    region = "us-west-1"
  }
}
