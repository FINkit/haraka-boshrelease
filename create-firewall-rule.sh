#!/usr/bin/env bash
gcloud compute firewall-rules create nat-to-sendgrid --target-tags nat --direction egress --allow tcp:2525 --network bosh --destination-ranges 159.122.224.196,159.122.224.197
