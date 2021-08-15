resource "aws_subnet" "publicSubnet" {
  for_each          = var.public_subnets
  vpc_id            = aws_vpc.myVpc.id
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.availability_zone
  tags = {
    Name      = "publicSubnet-${each.key}"
    Env       = "${var.env}"
    CreatedBy = "${var.created_by}"
  }
}

resource "aws_subnet" "privateSubnet" {
  for_each          = var.private_subnets
  vpc_id            = aws_vpc.myVpc.id
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.availability_zone
  tags = {
    Name      = "privateSubnet-${each.key}"
    Env       = "${var.env}"
    CreatedBy = "${var.created_by}"
  }
}