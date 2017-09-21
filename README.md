## Bosh-Haraka

https://haraka.github.io/README.html

## Assumptions:

1. You are using GCP
2. You are using Sendgrid as your upstream mail relay.
3. You ackknowledge that the only check for relaying is that the client is connecting from 10.0.0.0/8

## Prepare workspace

```
bosh upload-stemcell https://bosh.io/d/stemcells/bosh-google-kvm-ubuntu-trusty-go_agent
git clone https://github.com/migs/bosh-haraka.git
cd bosh-haraka
git submodule update -i
```

## Prepare haraka-secrets.yml

The `haraka-secrets.yml` file is excluded from git, so must be created manually.

The contents of the file should look like this:

```
haraka_smtp_forward_auth_user: username
haraka_smtp_forward_auth_pass: password
```

Replace the username and password required for the destination SMTP relay as required.


## Deployment

```
bosh create-release
bosh upload-release
bosh deploy -d bosh-haraka --recreate --vars-file=haraka-secrets.yml haraka.yml
```

## Firewall Rules

This release will need to reach the sendgrid (or some other smarthost), which will require the appropriate firewall rules to be configured. See `terraform/README.md` for a terraform module that can be included in your own terraform scripts.
