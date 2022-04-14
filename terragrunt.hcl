
locals {
  project  = "nap-devops-nonprod"
  region = "asia-southeast1"
}

inputs = {
  project = local.project
  region = local.region
  vpc_name  = "rke-demo-vpc"
  vpc_subnet = "rke-demo-subnet-001"

  vm_master_name_prefix = "rke-master"
  vm_worker_name_prefix = "rke-worker"

  profiles = {
    master1 = {
      machine_type = "e2-small"
      boot_disk_image = "projects/nap-devops-nonprod/global/images/ubuntu-20-develop"
      tags = ["rke-master"]
      disk_size = 100
    }

    worker1 = {
      machine_type = "e2-small"
      boot_disk_image = "projects/nap-devops-nonprod/global/images/ubuntu-20-develop"
      tags = ["rke-worker"]
      disk_size = 300
    }
  }

  master_nodes = [
    { 
      sequence = "01" 
      ip = "10.10.1.11" 
      zone = "a" 
      profile = "master1" 
    },
    { 
      sequence = "02"
      ip = "10.10.1.12"
      zone = "b"
      profile = "master1" 
    },  
    {
      sequence = "03"
      ip = "10.10.1.13"
      zone = "c"
      profile = "master1"
    }
  ]

  worker_nodes = [
    {
      sequence = "01"
      ip = "10.10.1.21"
      zone = "a"
      profile = "worker1" 
    },
    { 
      sequence = "02"
      ip = "10.10.1.22"
      zone = "b"
      profile = "worker1" 
    },
    { 
      sequence = "03"
      ip = "10.10.1.23"
      zone = "c"
      profile = "worker1" 
    }
  ]

  gce_rke_service_account = "gce-rke-demo@${local.project}.iam.gserviceaccount.com"
}

################################## Common ########################################

remote_state {
 backend = "gcs" 
 config = {
   bucket = "${local.project}-rke-tf"
   prefix = path_relative_to_include()
   project = "${local.project}"
   location = "${local.region}"
 }
}

generate "provider" {
  path = "provider.tf"

  if_exists = "overwrite_terragrunt"

  contents = <<EOF
provider "google" {
  project     = "${local.project}"
  region      = "${local.region}"
}

terraform {
  backend "gcs" {}
  required_providers {
    google = "4.10.0"
  }  
}
EOF
}
