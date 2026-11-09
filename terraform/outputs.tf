resource "local_file" "inventory" {
  filename = "${path.module}/../ansible/inventory.ini"
  content  = <<EOF
[builder]
builder ansible_host=${yandex_compute_instance.builder.network_interface.0.nat_ip_address} ansible_user=ubuntu

[prod]
prod ansible_host=${yandex_compute_instance.prod.network_interface.0.nat_ip_address} ansible_user=ubuntu
EOF
}

output "builder_ip" {
  value = yandex_compute_instance.builder.network_interface.0.nat_ip_address
}

output "prod_ip" {
  value = yandex_compute_instance.prod.network_interface.0.nat_ip_address
}
