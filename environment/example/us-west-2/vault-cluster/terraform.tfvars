ami_id                    = "ami-0d73728649c75d8c7"
ssh_key_name              = "vibrato-uswest2"
vault_cluster_name        = "vibrato-uswest-2-vault"
consul_cluster_name       = "vibrato-uswest-2-consul"
subnet_tags               = ["vibratoRetailUsWest2-private-us-west-2a","vibratoRetailUsWest1-private-us-west-2b"]
public_subnet_tags        = ["vibratoRetailUsWest2-public-us-west-2a"]
vpc_tags                  = { Name = "vibratoRetailUsWest2"}
auto_unseal_kms_key_stage = "UAT"
auto_unseal_kms_key_alias = "vault"
