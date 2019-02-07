name                = "vibratoRetailUsWest1"
cidr                = "10.1.0.0/16"
azs                 = ["us-west-1a", "us-west-1b"]
private_subnets     = ["10.1.1.0/24", "10.1.2.0/24"]
public_subnets      = ["10.1.101.0/24", "10.1.102.0/24"]
enable_nat_gateway  = true
enable_dns_hostnames= true
tags                = { Terraform = "true" Environment = "dev"}
