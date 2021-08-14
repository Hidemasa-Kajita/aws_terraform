resource "aws_eip" "eip" {
  for_each = aws_instance.webInstance
  instance = each.value.id
  vpc      = true
}