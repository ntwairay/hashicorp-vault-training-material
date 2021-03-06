name                = "hashicorptestUsWest2"
region              = "us-west-2"
cidr                = "10.2.0.0/16"
azs                 = ["us-west-2a", "us-west-2b", "us-west-2c"]
private_subnets     = ["10.2.1.0/28", "10.2.2.0/28", "10.2.3.0/28"]
public_subnets      = ["10.2.101.0/24", "10.2.102.0/24", "10.2.103.0/24"]
enable_nat_gateway  = true
enable_dns_hostnames= true
tags                = { Terraform = "true" Environment = "dev"}
