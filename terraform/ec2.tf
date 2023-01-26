# frontend instance
resource "aws_instance" "frontend" {
  ami           = "ami-0c68b55d1c875067e"
  instance_type = "t3.medium"
  availability_zone = "eu-west-1a"
  subnet_id     = aws_subnet.group-two-subnet-a.id
  vpc_security_group_ids = [aws_security_group.allow_web_traffic.id]
  key_name = "AMSKey"

  # run commands on deployment of the server
  user_data = <<-EOF
              #!/bin/bash
              sudo apt update -y
              echo frontend server started
              EOF 

  tags = {
    Name = "frontend"
  }
}

# backend instance
resource "aws_instance" "backend" {
  ami           = "ami-0c68b55d1c875067e"
  instance_type = "t3.medium"
  availability_zone = "eu-west-1a"
  subnet_id     = aws_subnet.group-two-subnet-a.id
  vpc_security_group_ids = [aws_security_group.allow_web_traffic.id]
  key_name = "AMSKey"

  # run commands on deployment of the server
  user_data = <<-EOF
              #!/bin/bash
              sudo apt update -y
              echo backend server started
              EOF 

  tags = {
    Name = "backend"
  }
}