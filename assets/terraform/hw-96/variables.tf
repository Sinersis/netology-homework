variable "instance_name" {
  type    = list(string)
  default = ["master-1", "master-2", "master-3", "master-4"]
}

variable "image_family" {
  type    = string
  default = "ubuntu-2204-lts"
}

variable "token" {
  type        = string
  description = "https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "ssh_key_path" {
  type    = string
  default = "~/.ssh/id_rsa.pub"
}

variable "ssh_private_key_path" {
  type    = string
  default = "~/.ssh/id_rsa"
}

variable "path_image_source" {
  type    = string
  default = "../../images/hw-96/img.png"
}

variable "access_key_bucket" {
  type    = string
  default = ""
}

variable "secret_key_bucket" {
  type    = string
  default = ""
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

