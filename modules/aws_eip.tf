resource "aws_eip" "eip" {
  count = length(aws_subnet.webPublicSubnet)
  vpc      = true
}