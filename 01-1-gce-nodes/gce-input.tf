
variable "gce_rke_service_account" {
  type = string
  nullable = false 
}

variable "project" {
  type     = string
  nullable = true
  default = ""
}

variable "region" {
  type     = string
  nullable = true
  default = ""
}

variable "vpc_name" {
  type     = string
  nullable = false 
}

variable "vpc_subnet" {
  type     = string
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
    zone = string
    profile = string
  }))
}

variable "worker_nodes" {
  type = list(object({
    sequence = string
    ip = string
    zone = string    
    profile = string
  }))
}

variable "profiles" {
  type = object({
    master1 = object({
      machine_type = string
      boot_disk_image = string
      disk_size = number
      tags = list(string)
    })

    worker1 = object({
      machine_type = string
      boot_disk_image = string
      disk_size = number
      tags = list(string)
    })
  })
}