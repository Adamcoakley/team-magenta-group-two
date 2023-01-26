output "ec2_instance_ip" {
    value = aws_instance.frontend.public_ip
}

output "ec2_instance_hostname" {
    value = aws_instance.frontend.id
}

output "ec2_instance_ip" {
    value = aws_instance.backend.public_ip
}

output "ec2_instance_hostname" {
    value = aws_instance.backend.id
}