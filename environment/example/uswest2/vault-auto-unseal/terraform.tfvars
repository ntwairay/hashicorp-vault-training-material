ami_id                    = "ami-0f7eca0fae40f2d46"
region                    = "us-west-2"
ssh_key_name              = "vibrato-uswest2"
vault_cluster_name        = "hashicorptest-uswest-2-vault"
consul_cluster_name       = "hashicorptest-uswest-2-consul"
subnet_tags               = ["hashicorptestUsWest2-private-us-west-2a","hashicorptestUsWest2-private-us-west-2b"]
public_subnet_tags        = ["hashicorptestUsWest2-public-us-west-2a"]
vpc_tags                  = { Name = "hashicorptestUsWest2"}
auto_unseal_kms_key_stage = "UAT"
auto_unseal_kms_key_alias = "vault"
