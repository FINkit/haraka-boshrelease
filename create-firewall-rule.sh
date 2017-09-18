#!/usr/bin/env bash
# Requires `gcloud version` to be at least 168.0.0
#gcloud compute firewall-rules create nat-to-sendgrid --target-tags nat --direction egress --allow tcp:2525 --network bosh --destination-ranges 159.122.224.196,159.122.224.197

set -e
set -x

GCP_ZONE=$(gcloud config get-value compute/zone 2>/dev/null)
GCP_REGION=$(gcloud config get-value compute/region 2>/dev/null)
GCP_PROJECT=$(gcloud config get-value project 2>/dev/null)
GCP_BASE_IP=10.0.0.0
GCP_SERVICE_ACCOUNT="bosh-user@${GCP_PROJECT}.iam.gserviceaccount.com"
GCP_APIS_TO_ENABLE=("compute.googleapis.com" "iam.googleapis.com" "cloudresourcemanager.googleapis.com" "dns.googleapis.com")
BOSH_CLI_VERSION="2.0.28"

export GOOGLE_CREDENTIALS=$(cat ~/${GCP_SERVICE_ACCOUNT}.key.json)

cd terraform

if [[ ! -d ".terraform" ]]; then
    terraform init
fi

terraform plan \
    -var service_account_email="${GCP_SERVICE_ACCOUNT}@${GCP_PROJECT}.iam.gserviceaccount.com" \
    -var projectid=${GCP_PROJECT} \
    -var region=${GCP_REGION} \
    -var zone=${GCP_ZONE} \
    -var baseip=${GCP_BASE_IP} \
    -var bosh_cli_version=${BOSH_CLI_VERSION}

terraform apply \
    -var service_account_email="${GCP_SERVICE_ACCOUNT}@${GCP_PROJECT}.iam.gserviceaccount.com" \
    -var projectid=${GCP_PROJECT} \
    -var region=${GCP_REGION} \
    -var zone=${GCP_ZONE} \
    -var baseip=${GCP_BASE_IP} \
    -var bosh_cli_version=${BOSH_CLI_VERSION}
