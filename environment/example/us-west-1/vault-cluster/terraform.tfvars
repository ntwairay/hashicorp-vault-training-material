ami_id                    = "ami-033cd038d6d9ab95f"
ssh_key_name              = "vibrato-uswest1"
vault_cluster_name        = "vibrato-uswest-1-vault"
consul_cluster_name        = "vibrato-uswest-1-consul"
subnet_tags               = ["vibratoRetailUsWest1-private-us-west-1a","vibratoRetailUsWest1-private-us-west-1b"]
public_subnet_tags        = ["vibratoRetailUsWest1-public-us-west-1a"]
vpc_tags                  = { Name = "vibratoRetailUsWest1"}
auto_unseal_kms_key_stage = "UAT"
auto_unseal_kms_key_alias = "vault"
