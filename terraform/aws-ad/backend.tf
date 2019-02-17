terraform {
  backend "s3" {
    bucket = ""
    key    = "ad"
    region = "us-west-1"
    encrypt = true
  }
}
