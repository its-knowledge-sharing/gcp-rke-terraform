
dependency "00-1-sa" {
  config_path = "../00-1-sa"
  skip_outputs = true
}

dependency "00-2-firewall" {
  config_path = "../00-2-firewall"
  skip_outputs = true
}

include "root" {
  path = find_in_parent_folders()
}
