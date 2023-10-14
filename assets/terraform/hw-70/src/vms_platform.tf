variable "vm_web_name" {
  type = string
  default = "netology-develop-platform-web"
  description = "Name VM"
}

variable "vm_web_platform_id" {
  type = string
  default = "standard-v1"
  description = "Platform ID"
}

variable "vm_web_preemptible" {
  type = bool
  default = true
}

variable "vm_db_name" {
  type = string
  default = "netology-develop-platform-db"
  description = "Name VM"
}

variable "vm_db_platform_id" {
  type = string
  default = "standard-v1"
  description = "Platform ID"
}

variable "vm_db_preemptible" {
  type = bool
  default = true
}