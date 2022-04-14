dependency "01-1-gce-nodes" {
  config_path = "../01-1-gce-nodes"
  skip_outputs = true
}

include "root" {
  path = find_in_parent_folders()
}
