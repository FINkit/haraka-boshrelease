#!/usr/bin/env bash
# Requires `gcloud version` to be at least 168.0.0
#gcloud compute firewall-rules create nat-to-sendgrid --target-tags nat --direction egress --allow tcp:2525 --network bosh --destination-ranges 159.122.224.196,159.122.224.197

set +e
set +x

zone=$(gcloud config get-value compute/zone 2>/dev/null)
region=$(gcloud config get-value compute/region 2>/dev/null)
projectid=$(gcloud config get-value project 2>/dev/null)
baseip=10.0.0.0
service_account_email="bosh-user@${projectid}.iam.gserviceaccount.com"
bosh_cli_version="2.0.28"

export GOOGLE_CREDENTIALS=$(cat ~/${service_account_email}.key.json)

cd terraform
if [[ ! -d "./plugins" ]]; then
    terraform init
fi
terraform apply
