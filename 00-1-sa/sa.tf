resource "google_service_account" "gce_sa_rke_demo" {
  account_id   = "gce-rke-demo"
  display_name = "Terraform - GCE service account for RKE"
}

#resource "google_project_iam_member" "gce_sa_rke_demo_storage_admin" {
#  project = var.project
#  role    = "roles/storage.objectAdmin"
#  member  = "serviceAccount:${google_service_account.gce_sa_rke_demo.email}"
#}
