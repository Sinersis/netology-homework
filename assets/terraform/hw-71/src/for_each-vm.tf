



resource "yandex_compute_instance" "db_platform" {
  for_each = var.vms_each_resource

  name        = var.vms_each_resource[each.key].name

  platform_id = var.vms_resources.platform_id
  resources {
    cores         = var.vms_each_resource[each.key].cores
    memory        = var.vms_each_resource[each.key].memory
    core_fraction = var.vms_each_resource[each.key].core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      size = var.vms_each_resource[each.key].disk
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

  depends_on = [yandex_compute_instance.web_platform]

}