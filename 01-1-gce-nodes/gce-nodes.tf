module "rke-masters" {
  for_each = toset(var.master_nodes)

  source          = "../modules/gce"

  vm_name         = "${var.vm_master_name_prefix}-${each.key}"
  vm_sequence     = "${each.value.sequence}"
  vm_tags         = ["dummy"]
  vm_service_account = var.gce_rke_service_account
  boot_disk_image  = "will-change"
  vm_machine_type  = "e2-small"
  vm_zone          = "${var.region}-a"
  vm_user          = "devops"
  vm_subnet        = "rke-demo-subnet-001"
  vm_ext_disk_size = 100 # 100GB
  project = var.project
  startup_script_path = "scripts/startup.bash"
  private_ip       = "192.168.1.1"
}
