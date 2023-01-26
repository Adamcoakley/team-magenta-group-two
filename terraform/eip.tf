# Provides an Elastic IP resource:
resource "aws_eip" "lb" {
  # boolean to specify wether the EIP is in a VPC or not
  vpc = true
  network_interface = aws_network_interface.group-two-ni.id
  associate_with_private_ip = "10.0.1.50"
  # EIP may require IGW to exist prior to association. 
  # Use depends_on to set an explicit dependency on the IGW.
  depends_on = [aws_internet_gateway.group-two-igw]
}