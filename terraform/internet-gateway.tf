resource "aws_internet_gateway" "group-two-igw" {
  # reference the vpc id
  vpc_id = aws_vpc.group-two-vpc.id

  tags = {
    Name = "group-two-igw"
  }
}