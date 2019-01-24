terraform {
  backend "s3" {
    bucket = ""
    key    = "vpc"
    region = "us-west-1"
    encrypt = true
  }
}
