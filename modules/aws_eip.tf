resource "aws_eip" "eip" {
  count = length(aws_subnet.publicSubnet)
  vpc      = true
}