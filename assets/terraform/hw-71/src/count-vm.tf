resource "yandex_compute_instance" "web_platform" {

  count = 2
  name        = "web-${count.index + 1}"

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

  metadata = {
    serial-port-enable = 1
    ssh-keys           = "ubuntu:${local.ssh-key}"
  }

}