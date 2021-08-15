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

resource "aws_route_table" "natRoute" {
  for_each = aws_nat_gateway.nat
  vpc_id = aws_vpc.myVpc.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = each.value.id
  }

  tags = {
    Name      = "natRoute-${each.key}"
    Env       = "${var.env}"
    CreatedBy = "${var.created_by}"
  }
}
