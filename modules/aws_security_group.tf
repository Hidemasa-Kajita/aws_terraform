resource "aws_security_group" "webSg" {
  description = "web security group"
  vpc_id      = aws_vpc.myVpc.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] // ip制限
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name      = "webSg"
    Env       = "${var.env}"
    CreatedBy = "${var.created_by}"
  }
}

resource "aws_security_group" "dbSg" {
  name   = "dbSecurityGroup"
  vpc_id = aws_vpc.myVpc.id
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name      = "dbSg"
    Env       = "${var.env}"
    CreatedBy = "${var.created_by}"
  }
}