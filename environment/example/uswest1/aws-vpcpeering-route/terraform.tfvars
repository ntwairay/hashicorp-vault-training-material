remote_state_aws_foundation_bucket  = "hashicorp-vibrato"
region                              = "us-west-1"
bucket_key                          = "vpcpeering"
route_table_tag_name                = "tag:Name"
r1_tag_values                       = ["hashicorptestUsWest1-private-us-west-1a"]
r2_tag_values                       = ["hashicorptestUsWest1-private-us-west-1b"]
peer_cidr_block                     = "10.2.0.0/16"
