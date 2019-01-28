#!/bin/bash
# This script is meant to be run in the User Data of each EC2 Instance while it's booting. The script uses the
# run-consul script to configure and start Consul in client mode and then the run-vault script to configure
# the auto unsealing on server init


set -e

# Send the log output from this script to user-data.log, syslog, and the console
# From: https://alestic.com/2010/12/ec2-user-data-output/
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

# The Packer template puts the TLS certs in these file paths
readonly VAULT_TLS_CERT_FILE="/opt/vault/tls/vault.crt.pem"
readonly VAULT_TLS_KEY_FILE="/opt/vault/tls/vault.key.pem"

# The cluster_tag variables below are filled in via Terraform interpolation
/opt/consul/bin/run-consul --client --cluster-tag-key "${consul_cluster_tag_key}" --cluster-tag-value "${consul_cluster_tag_value}"
/opt/vault/bin/run-vault \
  --tls-cert-file "$VAULT_TLS_CERT_FILE" \
  --tls-key-file "$VAULT_TLS_KEY_FILE" \
  --enable-auto-unseal \
  --auto-unseal-kms-key-id "${kms_key_id}" \
  --auto-unseal-kms-key-region "${aws_region}"


sleep 40
# When you ssh to one of the instances in the vault cluster and initialize the server
# You will notice it will now boot unsealed
# /opt/vault/bin/vault operator init
# /opt/vault/bin/vault status
#
# If the enterprise license isn't applied, it will however reseal after 30 minutes
# This is how you apply the license, please note that the VAULT_TOKEN environment
# variable needs to be set with the root token obtained when you initialized the server
# /opt/vault/bin/vault write /sys/license "text=<vault_enterprise_license_key>"


echo "--> Initializing vault"

export VAULT_ADDR="https://127.0.0.1:8200"
export VAULT_SKIP_VERIFY=true

if ! vault operator init -status >/dev/null; then
  curl \
    --silent \
    --insecure \
    --request PUT \
    --data '{"recovery_shares": 1, "recovery_threshold": 1}' \
    https://127.0.0.1:8200/v1/sys/init > /tmp/init

  cat /tmp/init | tr '\n' ' ' | jq -r .recovery_keys[0] | consul kv put service/vault/unseal-key -
  cat /tmp/init | tr '\n' ' ' | jq -r .root_token | consul kv put service/vault/root-token -

  vault auth enable -description="Authenticate using GitHub" github
  vault write auth/github/config organization=vibrato
  vault write auth/github/map/teams/vibrato-engineers value=admin

  # shred /tmp/unseal-key /tmp/init
fi

sleep 30

KEY="$(consul kv get service/vault/unseal-key)"
if [ "$KEY" ]; then
  vault operator unseal "$KEY" &> /dev/null
fi

echo "==> Vault is done!"
