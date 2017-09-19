resource "google_compute_firewall" "nat-to-sendgrid" {
  depends_on = ["google_compute_network.bosh"]
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
