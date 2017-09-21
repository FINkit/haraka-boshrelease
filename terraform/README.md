Place the following in your terraform scripts to call this module:

```
module "bosh-haraka" {
    source      = "github.com/migs/haraka-boshrelease//terraform"
    projectid   = "${var.projectid}"
    prefix      = "${var.prefix}"
    network     = "${google_compute_network.bosh.name}"
}
```
