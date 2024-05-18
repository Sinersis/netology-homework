resource "yandex_storage_bucket" "image-bucket" {
  bucket = "images-bucket-netology"
  access_key = var.access_key_bucket
  secret_key = var.secret_key_bucket

  anonymous_access_flags {
    read        = true
    list        = true
    config_read = true
  }
}

resource "yandex_storage_object" "image-object" {
  access_key = var.access_key_bucket
  secret_key = var.secret_key_bucket
  bucket = yandex_storage_bucket.image-bucket.bucket
  key    = "image.png"
  source = var.path_image_source
}