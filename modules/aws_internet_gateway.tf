resource "aws_internet_gateway" "myGw" {
  vpc_id = aws_vpc.myVpc.id
  tags = {
    Name      = "myGw"
    Env       = "${var.env}"
    CreatedBy = "${var.created_by}"
  }
}