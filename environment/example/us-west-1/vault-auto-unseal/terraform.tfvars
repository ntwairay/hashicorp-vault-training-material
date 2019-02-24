ami_id                    = "ami-0326a0906085ec849"
region                    = "us-west-1"
ssh_key_name              = "vibrato-uswest1"
vault_cluster_name        = "hashicorptest-uswest-1-vault"
consul_cluster_name       = "hashicorptest-uswest-1-consul"
subnet_tags               = ["hashicorptestUsWest1-private-us-west-1a","hashicorptestUsWest1-private-us-west-1b"]
public_subnet_tags        = ["hashicorptestUsWest1-public-us-west-1a"]
vpc_tags                  = { Name = "hashicorptestUsWest1"}
auto_unseal_kms_key_stage = "UAT"
auto_unseal_kms_key_alias = "vault-test"
