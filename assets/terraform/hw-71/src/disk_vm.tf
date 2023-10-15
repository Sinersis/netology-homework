resource "yandex_compute_disk" "default" {
  count = 3
  name     = "disk-name-${count.index}"
  type     = "network-ssd"
  zone     = "ru-central1-a"
  image_id = data.yandex_compute_image.ubuntu.image_id
  size = 5
}

resource "yandex_compute_instance" "storage_platform" {

  name        = "storage"
  platform_id = var.vms_resources.platform_id

  resources {
    cores         = var.vms_resources.cores
    memory        = var.vms_resources.memory
    core_fraction = var.vms_resources.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = var.vms_resources.preemptible
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
    security_group_ids = [yandex_vpc_security_group.example.id]
  }
  dynamic "secondary_disk" {
    for_each = [for values in yandex_compute_disk.default[*] : values.id]
    content {
      disk_id = secondary_disk.value
    }
  }

  metadata = {
    serial-port-enable = 1
    ssh-keys           = "ubuntu:${local.ssh-key}"
  }
  depends_on = [yandex_compute_disk.default]
}