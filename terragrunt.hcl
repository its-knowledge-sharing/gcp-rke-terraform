
locals {
  project  = "nap-devops-nonprod"
  region = "asia-southeast1"
}

inputs = {
  ##### Start define nodes here #####
  master_nodes = [
    { 
      sequence = "01" 
      ip = "10.10.1.11" 
      zone = "a" 
      profile = "master1" 
      mode = "registered" #unregistered
    },
    { 
      sequence = "02"
      ip = "10.10.1.12"
      zone = "b"
      profile = "master1"
      mode = "registered"
    },  
    {
      sequence = "03"
      ip = "10.10.1.13"
      zone = "c"
      profile = "master1"
      mode = "registered"
    }
  ]

  worker_nodes = [
    {
      sequence = "01"
      ip = "10.10.1.21"
      zone = "a"
      profile = "worker1"
      mode = "registered" #unregistered
    },
    {
      sequence = "02"
      ip = "10.10.1.22"
      zone = "b"
      profile = "worker1"
      mode = "registered"
    },
    { 
      sequence = "03"
      ip = "10.10.1.23"
      zone = "c"
      profile = "worker1"
      mode = "registered"
    },
    { 
      sequence = "04"
      ip = "10.10.1.24"
      zone = "a"
      profile = "worker1"
      mode = "registered"
    },
    { 
      sequence = "05"
      ip = "10.10.1.25"
      zone = "b"
      profile = "worker1"
      mode = "registered"
    }
  ]
  ##### End define nodes #####

  profiles = {
    master1 = {
      machine_type = "e2-standard-2"
      boot_disk_image = "projects/nap-devops-nonprod/global/images/ubuntu-20-develop"
      tags = ["rke-master"]
      disk_size = 100
      role = ["controlplane", "etcd"]
    }

    worker1 = {
      machine_type = "e2-standard-2"
      boot_disk_image = "projects/nap-devops-nonprod/global/images/ubuntu-20-develop"
      tags = ["rke-worker"]
      disk_size = 300
      role = ["worker"]
    }
  }


  project = local.project
  region = local.region
  vpc_name  = "rke-demo-vpc"
  vpc_subnet = "rke-demo-subnet-001"

  vm_user = "devops"
  vm_master_name_prefix = "rke-master"
  vm_worker_name_prefix = "rke-worker"

  rke_cluster_name = "rke-demo"
  rke_k8s_version = "v1.21.7-rancher1-1"
  rke_ignore_docker_version = true
  rke_prefix_path = "/var/lib/toolbox/rke"
  rke_ssh_key_path = "../id_rsa" # Retrieved from Secret Manager

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
  
provider "rke" {
  log_file = "../rke-cluster.log"
}

terraform {
  backend "gcs" {}
  required_providers {
    google = "4.10.0"

    rke = {
      version = "1.3.0"
      source = "rancher/rke"
    }
  }
}
EOF
}
