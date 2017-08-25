## Bosh-Haraka

https://haraka.github.io/README.html

## Deployment

From your bosh-bastion:

```
git clone https://github.com/migs/bosh-haraka.git
cd bosh-haraka
git submodule update -i
bosh ucc bosh-cloud-configs/gcp/europe-west2.yml
bosh create-release
bosh upload-release
bosh deploy -d bosh-haraka manifest.yml
