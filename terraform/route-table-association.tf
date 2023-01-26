# create an association between a route table and a subnet
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.group-two-subnet-a.id
  route_table_id = aws_route_table.group-two-rt.id
}

