resource "aws_subnet" "webPublicSubnet" {
  for_each          = var.web_subnets
  vpc_id            = aws_vpc.myVpc.id
  cidr_block        = each.value.cidr_block
  availability_zone = var.availability_zone.a
  tags = {
    Name      = "publicSubnet-${each.key}"
    Env       = "${var.env}"
    CreatedBy = "${var.created_by}"
  }
}

resource "aws_subnet" "dbPrivateSubnet" {
  for_each          = var.db_subnets
  vpc_id            = aws_vpc.myVpc.id
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.availability_zone
  tags = {
    Name      = "privateSubnet-${each.key}"
    Env       = "${var.env}"
    CreatedBy = "${var.created_by}"
  }
}