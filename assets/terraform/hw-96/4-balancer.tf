resource "yandex_lb_network_load_balancer" "netology-balancer" {
  depends_on = [yandex_compute_instance_group.netology-group]
  name = "netology-balancer"

  listener {
    name = "netology-balancer-1-listener"
    port = 80
    external_address_spec {
      ip_version = "ipv4"
    }
  }

  attached_target_group {
    target_group_id = yandex_compute_instance_group.netology-group.load_balancer.0.target_group_id

    healthcheck {
      name = "http"
      http_options {
        port = 80
        path = "/index.html"
      }
    }
  }
}