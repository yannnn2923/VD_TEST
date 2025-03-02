#!/bin/sh

prefix=$1

if [[ $prefix == "" ]]; then
    echo "Veuillez indiquer l'identifiant lié à votre trigramme"
    exit 1
fi
postgres_user="m_btod1_exploit"

# Get db host via vault
curl_output=$(curl -fs -H "X-Vault-Token: ${VAULT_TOKEN}" "https://vault.apps.eul.sncf.fr/v1/database_d/config/?list=true")
if [[ $? > 0 ]];then
    echo "Un token valide doit être affecté à la variable d'environnement ${VAULT_TOKEN}"
    exit 2
fi
postgres_connection=$(echo $curl_output | jq -r ".data.keys[]|select(. | test(\"btod1\"))")
postgres_host=$(curl -fs -H "X-Vault-Token: ${VAULT_TOKEN}" "https://vault.apps.eul.sncf.fr/v1/database_d/config/${postgres_connection}" | jq -r '.data.connection_details.connection_url|match("@(?<url>.*):").captures[]|select(.name=="url").string')
b64_postgres_host=$(echo ${postgres_host} | base64)

# Get db password via vault
postgres_password=$(curl -fs -H "X-Vault-Token: ${VAULT_TOKEN}" "https://vault.apps.eul.sncf.fr/v1/database_d/static-creds/${postgres_connection}_m_exploit" | jq -r '.data.password')

b64_postgres_user=$(echo ${postgres_user} | base64)
b64_postgres_db=$(echo btod1 | base64)
b64_postgres_password=$(echo $postgres_password | base64)
b64_postgres_port=$(echo 5433 | base64)
b64_url_prefix=$(echo $prefix | base64)
cat << EOF
apiVersion: v1
kind: Secret
metadata:
  name: ${1}-postgres-credentials
data:
  POSTGRES_PASSWORD: "${b64_postgres_password}"
  POSTGRES_USER: "${b64_postgres_user}"
  POSTGRES_DB: "${b64_postgres_db}"
  POSTGRES_HOST: "${b64_postgres_host}"
  POSTGRES_PORT: "${b64_postgres_port}"
  URL_PREFIX: "${b64_url_prefix}"
EOF
