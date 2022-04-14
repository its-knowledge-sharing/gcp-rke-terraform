output "kube_config_yaml" {
  value = rke_cluster.rke-cluster.kube_config_yaml
  sensitive = true
}

output "rke_state" {
  value = rke_cluster.rke-cluster.rke_state
  sensitive = true
}
