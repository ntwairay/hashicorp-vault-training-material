terraform {
  backend "s3" {
    bucket = ""
    key    = "vault-cluster"
    region = "us-west-1"
    encrypt = true
  }
}
