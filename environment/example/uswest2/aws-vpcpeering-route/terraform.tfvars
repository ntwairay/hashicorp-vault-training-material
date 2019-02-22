remote_state_aws_foundation_bucket = "hashicorp-vibrato"
region                             = "us-west-2"
route_table_tag_name               = "tag:Name"
r1_tag_values                      = ["hashicorptestUsWest2-private-us-west-2a"]
r2_tag_values                      = ["hashicorptestUsWest2-private-us-west-2b"]
peer_cidr_block                    = "10.1.0.0/16"
bucket_key                         = "vpcpeering"
