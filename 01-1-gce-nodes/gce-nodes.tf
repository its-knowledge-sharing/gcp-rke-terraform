module "rke-masters" {
  for_each = {for vm in var.master_nodes: vm.sequence => vm}

  source          = "../modules/gce"

  vm_name         = "${var.vm_master_name_prefix}"
  vm_sequence     = "${each.value.sequence}"
  vm_tags         = lookup(var.profiles, each.value.profile, {}).tags
  vm_service_account = var.gce_rke_service_account
  boot_disk_image  = "will-change"
  vm_machine_type  = "e2-small"
  vm_zone          = "${var.region}-${each.value.zone}"
  vm_user          = "devops"
  vm_subnet        = var.vpc_subnet
  vm_ext_disk_size = 100 # 100GB
  project = var.project
  startup_script_path = "scripts/startup.bash"
  private_ip       = "${each.value.ip}"
}
