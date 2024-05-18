resource "yandex_compute_instance" "nat-instance-platform" {
  name        = "nat-instance-platform"
  platform_id = "standard-v1"

  resources {
    cores         = 2
    memory        = 2
    core_fraction = 5
  }

  boot_disk {
    initialize_params {
      image_id = "fd80mrhj8fl2oe87o4e1"
      size     = 30
      type     = "network-ssd"
    }
  }

  scheduling_policy {
    preemptible = true
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.netology-network-public.id
    ip_address = "192.168.10.254"
    nat = true
  }

  metadata = {
    serial-port-enable = 1
    ssh-keys           = "ubuntu:${local.ssh-key}"
  }

  provisioner "remote-exec" {
    inline = ["ping -c 10 ya.ru"]

    connection {
      host        = self.network_interface[0].nat_ip_address
      type        = "ssh"
      user        = "ubuntu"
      private_key = file(var.ssh_private_key_path)
      agent       = true
    }
  }
}