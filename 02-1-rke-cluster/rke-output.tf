output "kube_config_yaml" {
  value = rke_cluster.rke-cluster.kube_config_yaml
}

output "rke_state" {
  value = rke_cluster.rke-cluster.rke_state
}
