terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  zone             = "kz1-a"
  endpoint         = "api.yandexcloud.kz:443"
  storage_endpoint = "https://storage.yandexcloud.kz"
}


resource "yandex_compute_image" "ubuntu" {
  source_family = "ubuntu-2404-lts"
}

resource "yandex_vpc_network" "network" {
  name = "app-network"
}

resource "yandex_vpc_subnet" "subnet" {
  network_id     = yandex_vpc_network.network.id
  v4_cidr_blocks = ["192.168.10.0/24"]
  zone           = "kz1-a"
}

resource "yandex_compute_instance" "builder" {
  name        = "builder-vm"
  platform_id = "standard-v3"
  zone        = "kz1-a"

  resources {
    cores  = 2
    memory = 2
  }

boot_disk {
    initialize_params {
      image_id = yandex_compute_image.ubuntu.id
      size     = 20
    }
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.subnet.id
    nat       = true
  }
  metadata = {
    ssh-keys = "ubuntu:${file(var.ssh_public_key_path)}"
  }
}

resource "yandex_compute_instance" "prod" {
  name        = "prod-vm"
  platform_id = "standard-v3"
  zone        = "kz1-a"

  resources {
    cores  = 2
    memory = 4
  }
  boot_disk {
    initialize_params {
      image_id = yandex_compute_image.ubuntu.id
      size     = 20
    }
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.subnet.id
    nat       = true
  }
  metadata = {
    ssh-keys = "ubuntu:${file(var.ssh_public_key_path)}"
  }
}
