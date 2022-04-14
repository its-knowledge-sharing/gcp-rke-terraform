
resource "google_compute_firewall" "rke-inter-connect" {
  name    = "rke-inter-connect-allow"
  network = var.vpc_name
  priority = 1000

  allow {
    protocol = "tcp"
    ports    = ["22", "80", "443", "6443"] #More to add
  }

  source_tags = ["rke-worker", "rke-master"]
  target_tags = ["rke-worker", "rke-master"]
}