# Populate inventory file with dynamic ips
resource "local_file" "dynamic_inventory" {
  content  = "[webservers]\n ${aws_instance.group-two-server.public_ip}\n"
  filename = "../inventory.yaml"
}