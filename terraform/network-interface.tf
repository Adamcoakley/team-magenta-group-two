# Provides an Elastic network interface (ENI) resource
resource "aws_network_interface" "group-two-ni" {
  # reference the subnet
  subnet_id       = aws_subnet.group-two-subnet-a.id
  # specify an IP within the subnet:
  private_ips     = ["10.0.1.50"]
  # reference the security group
  security_groups = [aws_security_group.allow_web_traffic.id]
}