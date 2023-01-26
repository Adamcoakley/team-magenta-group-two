output "ec2_instance_frontend" {
    value = aws_instance.frontend.public_ip
}

output "ec2_instance_hostname_frontend" {
    value = aws_instance.frontend.id
}

output "ec2_instance_backend" {
    value = aws_instance.backend.public_ip
}

output "ec2_instance_hostname_backend" {
    value = aws_instance.backend.id
}

# Populate inventory file with dynamic ips
resource "local_file" "dynamic_inventory" {
  content  = "[all_instances]\n ${aws_instance.frontend.public_ip}\n ${aws_instance.backend.public_ip} \n \n [frontend]\n ${aws_instance.frontend.public_ip}\n \n [backend]\n ${aws_instance.backend.public_ip}"
  filename = "./inventory.yml"
}