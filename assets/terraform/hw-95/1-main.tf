terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

locals {
  ssh-key = file(var.ssh_key_path)
}

data "yandex_compute_image" "ubuntu" {
  family = var.image_family
}

provider "yandex" {
  token     = var.token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.default_zone
}

resource "yandex_vpc_network" "netology-network" {
  name = "netology-network"
}

resource "yandex_vpc_subnet" "netology-network-public" {
  name = "netology-network-public"
  v4_cidr_blocks = ["192.168.10.0/24"]
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.netology-network.id
}

resource "yandex_vpc_subnet" "netology-network-private" {
  name = "netology-network-private"
  v4_cidr_blocks = ["192.168.20.0/24"]
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.netology-network.id
  route_table_id = yandex_vpc_route_table.netology-route-table.id
}