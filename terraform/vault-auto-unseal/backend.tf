terraform {
  backend "s3" {
    bucket = "hashicorp-vibrato"
    key    = ""
    region = "us-west-1"
    encrypt = true
  }
}
