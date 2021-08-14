resource "aws_db_instance" "dbInsrance" {
  allocated_storage      = 10
  engine                 = "mysql"
  engine_version         = "5.7"
  instance_class         = "db.t3.micro"
  name                   = var.db_name
  username               = var.db_username
  password               = var.db_password
  parameter_group_name   = "default.mysql5.7"
  vpc_security_group_ids = ["${aws_security_group.dbSg.id}"]
  db_subnet_group_name   = aws_db_subnet_group.dbSubnetGroup.name
  skip_final_snapshot    = true

  tags = {
    Name      = "dbInsrance"
    Env       = "${var.env}"
    CreatedBy = "${var.created_by}"
  }
}