resource "aws_route_table" "group-two-rt" {
  # reference the vpc id 
  vpc_id = aws_vpc.group-two-vpc.id

  # define the routes for the route table
  route {
    # all ipv4 traffic to igw
    cidr_block = "0.0.0.0/0" 
    # reference the igw
    gateway_id = aws_internet_gateway.group-two-igw.id
  }

  route {
    # all ipv6 traffic to igw
    ipv6_cidr_block = "::/0" 
    # reference the igw
    gateway_id = aws_internet_gateway.group-two-igw.id
  }

  tags = {
    Name = "group-two-rt"
  }
}