resource "yandex_compute_instance_group" "netology-group" {
  depends_on = [yandex_storage_object.image-object]
  name                          = "netology-group"
  service_account_id            = yandex_iam_service_account.netology-sa.id
  folder_id = var.folder_id

  instance_template {
    platform_id = "standard-v1"

    resources {
      cores         = 2
      memory        = 2
      core_fraction = 5
    }

    boot_disk {
      mode = "READ_WRITE"
      initialize_params {
        image_id = data.yandex_compute_image.ubuntu.image_id
        size     = 30
        type     = "network-ssd"
      }
    }

    scheduling_policy {
      preemptible = true
    }

    network_interface {
      network_id = yandex_vpc_network.netology-network.id
      subnet_ids = [yandex_vpc_subnet.netology-network-public.id]
      nat = true
    }

    metadata = {
      serial-port-enable = 1
      ssh-keys           = "ubuntu:${local.ssh-key}"
      user-data          = file("${path.module}/meta-data.yml")
    }

    network_settings {
      type = "STANDARD"
    }
  }

  deploy_policy {
    max_unavailable = 2
    max_creating = 2
    max_expansion = 2
    max_deleting = 2
  }

  load_balancer {
    target_group_name        = "netology-group"
    target_group_description = "Целевая группа Network Load Balancer"
  }

  allocation_policy {
    zones = [var.default_zone]
  }

  scale_policy {
    fixed_scale {
      size = 3
    }
  }
}