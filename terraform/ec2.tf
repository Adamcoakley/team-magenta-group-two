# frontend instance
resource "aws_instance" "frontend" {
  ami           = "ami-0c68b55d1c875067e"
  instance_type = "t3.medium"
  availability_zone = "eu-west-1a"
  key_name = "AMSKey"
  

  network_interface {
    # device index (required)
    device_index = 0
    network_interface_id = aws_network_interface.group-two-ni.id
  }

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
  key_name = "AMSKey"

  network_interface {
    # device index (required)
    device_index = 0
    network_interface_id = aws_network_interface.group-two-ni.id
  }

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