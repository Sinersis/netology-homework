locals {
  databases = tomap(yandex_compute_instance.db_platform)
  storages = [yandex_compute_instance.storage_platform]
  webservers = yandex_compute_instance.web_platform
}



resource "local_file" "inventory" {
  content = templatefile("./inventory.tftpl",
    {
      servers = {
        webservers = local.webservers,
        databases = local.databases ,
        storages = local.storages
      }
    }
  )

  filename = "./inventory"
}