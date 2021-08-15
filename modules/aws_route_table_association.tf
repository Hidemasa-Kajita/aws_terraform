resource "aws_route_table_association" "puclicRouteWeb" {
  for_each       = aws_subnet.webPublicSubnet
  subnet_id      = each.value.id
  route_table_id = aws_route_table.publicRoute.id
}

resource "aws_route_table_association" "natRouteWeb" {
  for_each       = aws_subnet.dbPrivateSubnet
  subnet_id      = each.value.id
  route_table_id = aws_route_table.natRoute[each.key].id
}