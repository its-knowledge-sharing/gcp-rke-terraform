
resource "google_compute_firewall" "rke-inter-connect" {
  name    = "rke-inter-connect-allow"
  network = var.vpc_name
  priority = 1000

  allow {
    protocol = "tcp"
    #ports    = ["443", "80", "9094", "9095", "9096", "4001", "8080", "5001", "5353"] #More to add
  }

  source_tags = ["rke-worker", "rke-master"]
  target_tags = ["rke-worker", "rke-master"]
}