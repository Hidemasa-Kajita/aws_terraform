resource "aws_db_subnet_group" "dbSubnetGroup" {
  name = "dbsubnetgroup"
  subnet_ids = [
    for v in aws_subnet.privateSubnet : v.id
  ]

  tags = {
    Name      = "dbSubnetGroup"
    Env       = "${var.env}"
    CreatedBy = "${var.created_by}"
  }
}