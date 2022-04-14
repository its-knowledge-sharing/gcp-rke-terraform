module "rke-masters" {
  for_each = { for vm in var.master_nodes: vm.sequence => vm }

  source          = "../modules/gce"

  vm_name         = "${var.vm_master_name_prefix}"
  vm_sequence     = "${each.value.sequence}"
  vm_service_account = var.gce_rke_service_account
  vm_zone          = "${var.region}-${each.value.zone}"
  vm_user          = var.vm_user
  vm_subnet        = var.vpc_subnet
  project = var.project
  startup_script_path = "scripts/startup.bash"
  private_ip       = "${each.value.ip}"

  vm_tags          = lookup(var.profiles, each.value.profile, {}).tags
  boot_disk_image  = lookup(var.profiles, each.value.profile, {}).boot_disk_image
  vm_machine_type  = lookup(var.profiles, each.value.profile, {}).machine_type
  vm_ext_disk_size = lookup(var.profiles, each.value.profile, {}).disk_size
}

module "rke-workers" {
  for_each = { for vm in var.worker_nodes: vm.sequence => vm }

  source          = "../modules/gce"

  vm_name         = "${var.vm_worker_name_prefix}"
  vm_sequence     = "${each.value.sequence}"
  vm_service_account = var.gce_rke_service_account
  vm_zone          = "${var.region}-${each.value.zone}"
  vm_user          = var.vm_user
  vm_subnet        = var.vpc_subnet
  project = var.project
  startup_script_path = "scripts/startup.bash"
  private_ip       = "${each.value.ip}"

  vm_tags          = lookup(var.profiles, each.value.profile, {}).tags
  boot_disk_image  = lookup(var.profiles, each.value.profile, {}).boot_disk_image
  vm_machine_type  = lookup(var.profiles, each.value.profile, {}).machine_type
  vm_ext_disk_size = lookup(var.profiles, each.value.profile, {}).disk_size
}
