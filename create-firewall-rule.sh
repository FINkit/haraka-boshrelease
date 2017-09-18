#!/usr/bin/env bash
# Requires `gcloud version` to be at least 168.0.0
#gcloud compute firewall-rules create nat-to-sendgrid --target-tags nat --direction egress --allow tcp:2525 --network bosh --destination-ranges 159.122.224.196,159.122.224.197

set +e
set +x

zone=$(gcloud config get-value compute/zone 2>/dev/null)
region=$(gcloud config get-value compute/region 2>/dev/null)
project=$(gcloud config get-value project 2>/dev/null)
baseip=10.0.0.0
service_account_email="bosh-user@${GCP_PROJECT}.iam.gserviceaccount.com"
bosh_cli_version="2.0.28"

export GOOGLE_CREDENTIALS=$(cat ~/${GCP_SERVICE_ACCOUNT}.key.json)

sudo docker run -i -t \
  -e "GOOGLE_CREDENTIALS=${GOOGLE_CREDENTIALS}" \
  -v `pwd`/terraform:/$(basename `pwd`) \
  -w /$(basename `pwd`) \
  hashicorp/terraform:full apply \
    -var service_account_email="${GCP_SERVICE_ACCOUNT}@${GCP_PROJECT}.iam.gserviceaccount.com" \
    -var projectid=${GCP_PROJECT} \
    -var region=${GCP_REGION} \
    -var baseip=${GCP_BASE_IP} \
    -var bosh_cli_version=${BOSH_CLI_VERSION}
