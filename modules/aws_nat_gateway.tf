resource "aws_nat_gateway" "nat" {
  for_each = aws_subnet.publicSubnet
  subnet_id     = each.value.id
  allocation_id = aws_eip.eip[each.key].id

  tags = {
    Name      = "nat-${each.key}"
    Env       = "${var.env}"
    CreatedBy = "${var.created_by}"
  }
}