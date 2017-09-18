variable "projectid" {
    type = "string"
}

variable "prefix" {
    type = "string"
    default = ""
}

variable "region" {
    type = "string"
    default = "europe-west2"
}

provider "google" {
    project = "${var.projectid}"
    region = "${var.region}"
}

resource "google_compute_network" "bosh" {
  name       = "${var.prefix}bosh"
}

resource "google_compute_firewall" "nat-to-sendgrid" {
  name    = "${var.prefix}nat-to-sendgrid"
  network = "${google_compute_network.bosh.name}"

  direction = "EGRESS"

  destination_ranges = ["159.122.224.196/32", "159.122.224.197/32"]

  allow {
    protocol = "tcp"
    ports    = ["2525"]
  }

  target_tags = ["nat"]
}

