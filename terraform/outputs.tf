output "ec2_instance_ip" {
     value = aws_instance.group-two-server.public_ip
 }

 output "ec2_instance_hostname" {
     value = aws_instance.group-two-server.id
 }