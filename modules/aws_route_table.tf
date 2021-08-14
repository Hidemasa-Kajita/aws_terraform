resource "aws_route_table" "publicRoute" {
  vpc_id = aws_vpc.myVpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.myGw.id
  }

  tags = {
    Name      = "publicRoute"
    Env       = "${var.env}"
    CreatedBy = "${var.created_by}"
  }
}
