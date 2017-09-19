Place the following in your terraform scripts to call this module:

```
module "bosh-haraka" {
    source      = "github.com/migs/bosh-haraka//terraform"
    projectid   = "${var.projectid}"
    prefix      = "${var.prefix}"
}
```
