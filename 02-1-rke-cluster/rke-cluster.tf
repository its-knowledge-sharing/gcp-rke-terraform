
resource rke_cluster "rke-cluster" {
  cluster_name = var.rke_cluster_name
  kubernetes_version = var.rke_k8s_version
  ignore_docker_version = var.rke_ignore_docker_version
  prefix_path = var.rke_prefix_path
  cluster_yaml = file("configs/cluster.yaml")
  
  dynamic "nodes" {
    for_each = [ for vm in var.worker_nodes: {
      name = "${var.vm_master_name_prefix}-${vm.sequence}"
      address = vm.ip

      role = lookup(var.profiles, vm.profile, {}).role
    }]

    content {
      #hostname_override = nodes.name
      address = nodes.address
      internal_address = nodes.address
      user             = var.vm_user
      role             = nodes.role
      ssh_key          = file(var.rke_ssh_key_path)      
    }
  }
}
