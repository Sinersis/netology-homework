resource "yandex_kms_symmetric_key" "netology-key" {
  name              = "netology-key"
  description       = "Some key"
  default_algorithm = "AES_128"
  rotation_period   = "8760h"
}

resource "yandex_storage_bucket" "kms-images-bucket-netology" {
  depends_on = [yandex_kms_symmetric_key.netology-key]
  bucket = "kms-images-bucket-netology"
  access_key = var.access_key_bucket
  secret_key = var.secret_key_bucket

  anonymous_access_flags {
    read        = true
    list        = true
    config_read = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = yandex_kms_symmetric_key.netology-key.id
        sse_algorithm     = "aws:kms"
      }
    }
  }
}

resource "yandex_storage_object" "image-object" {
  depends_on = [yandex_storage_bucket.kms-images-bucket-netology]
  access_key = var.access_key_bucket
  secret_key = var.secret_key_bucket
  bucket = yandex_storage_bucket.kms-images-bucket-netology.bucket
  key    = "image.png"
  source = var.path_image_source
}