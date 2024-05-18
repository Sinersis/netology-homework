resource "yandex_vpc_route_table" "netology-route-table" {
  network_id = yandex_vpc_network.netology-network.id
  static_route {
    destination_prefix = "0.0.0.0/0"
    next_hop_address = yandex_compute_instance.nat-instance-platform.network_interface[0].ip_address
  }
}