###cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network&subnet name"
}

variable "ssh_key" {
  type = string
  default = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAQRhIzzB7au4bEu2P4vTJh+ZHPzjzsj14sizylTQM5H melentev.av@gmail.com"
}

variable "vms_os_family" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "OS family for install"
}

variable "vms_resources" {
  type = object({
    cores = number
    memory = number
    core_fraction = number
    platform_id = string
    preemptible = bool
  })

  default = {
      cores         = 2
      memory        = 1
      core_fraction = 5
      platform_id   = "standard-v1"
      preemptible   = true
  }
}


variable "vms_each_resource" {
  type = map(object({
    name = string
    cores = number
    memory = number
    core_fraction = number
    disk = number
  }))

  default = {
    1 = {
      name = "main"
      cores = 2
      memory = 2
      core_fraction = 5
      disk = 20
    },
    0 = {
      name = "replica"
      cores = 2
      memory = 4
      core_fraction = 5
      disk = 50
    }
  }
}