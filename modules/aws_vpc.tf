resource "aws_vpc" "myVpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = false
  tags = {
    Name      = "myVpc"
    Env       = "${var.env}"
    CreatedBy = "${var.created_by}"
  }
}