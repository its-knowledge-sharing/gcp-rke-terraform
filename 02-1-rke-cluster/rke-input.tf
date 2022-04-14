
variable "rke_cluster_name" {
  type = string
  nullable = false 
}

variable "rke_k8s_version" {
  type = string
  nullable = false 
}

variable "rke_ignore_docker_version" {
  type = bool
  nullable = false 
}

variable "rke_prefix_path" {
  type = string
  nullable = false 
}

variable "rke_ssh_key_path" {
  type = string
  nullable = false 
}

variable "vm_master_name_prefix" {
  type     = string
  nullable = false 
}

variable "vm_worker_name_prefix" {
  type     = string
  nullable = false 
}

variable "vm_user" {
  type     = string
  nullable = false 
}

variable "master_nodes" {
  type = list(object({
    sequence = string
    ip = string
    profile = string
  }))
}

variable "worker_nodes" {
  type = list(object({
    sequence = string
    ip = string
    profile = string
  }))
}

variable "profiles" {
  type = object({
    master1 = object({
      role = list(string)
    })

    worker1 = object({
      role = list(string)
    })
  })
}