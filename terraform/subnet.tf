resource "aws_subnet" "group-two-subnet-a" {
  # reference the vpc
  vpc_id     = aws_vpc.group-two-vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "eu-west-1a"

  tags = {
    Name = "group-two-subnet-a"
  }
}