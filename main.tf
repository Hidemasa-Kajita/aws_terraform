variable "access_key" {}
variable "secret_key" {}
variable "region" {}
variable "availability_zone" {}

provider "aws" {
    access_key = "${var.access_key}"
    secret_key = "${var.secret_key}"
    region = "${var.region}"
}

resource "aws_vpc" "myVpc" {
    cidr_block = "10.0.0.0/24"
    instance_tenancy = "default"
    enable_dns_support = true
    enable_dns_hostnames = false
    tags = {
      name = "myVpc"
      env = "dev"
      author = "terraform"
    }
}

resource "aws_internet_gateway" "myGw" {
    vpc_id = "${aws_vpc.myVpc.id}"
    tags = {
      name = "myGw"
      env = "dev"
      author = "terraform"
    }
}

resource "aws_subnet" "publicWeb-1" {
    vpc_id = "${aws_vpc.myVpc.id}"
    cidr_block = "10.0.0.0/28"
    availability_zone = "${var.availability_zone.a}"
    tags = {
      name = "publicWeb-1"
      env = "dev"
      author = "terraform"
    }
}

resource "aws_route_table" "publicRoute" {
    vpc_id = "${aws_vpc.myVpc.id}"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.myGw.id}"
    }

    tags = {
      name = "publicRoute"
      env = "dev"
      author = "terraform"
    }
}

resource "aws_route_table_association" "puclicRouteWeb-1" {
    subnet_id = "${aws_subnet.publicWeb-1.id}"
    route_table_id = "${aws_route_table.publicRoute.id}"
}

resource "aws_security_group" "webSg" {
    description = "web security group"
    vpc_id = "${aws_vpc.myVpc.id}"
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"] // ip制限
    }
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
      name = "webSg"
      env = "dev"
      author = "terraform"
    }
}

resource "aws_key_pair" "sshKey" {
  key_name   = "key"
  public_key = file("./.ssh/key.pub")

  tags = {
    name = "sshKey"
    env = "dev"
    author = "terraform"
  }
}

data aws_ssm_parameter amzn2_ami {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

resource "aws_instance" "webInstance-1" {
    ami = data.aws_ssm_parameter.amzn2_ami.value
    instance_type = "t2.micro"
    key_name = "${aws_key_pair.sshKey.key_name}"
    vpc_security_group_ids = [
      "${aws_security_group.webSg.id}"
    ]
    subnet_id = "${aws_subnet.publicWeb-1.id}"
    associate_public_ip_address = true

    tags = {
      name = "webInstance-1"
      env = "dev"
      author = "terraform"
    }
}

resource "aws_eip" "eip-1" {
    instance = "${aws_instance.webInstance-1.id}"
    vpc = true
}

# resource "aws_subnet" "dbSubnet-1" {
#     vpc_id = "${aws_vpc.myVpc.id}"
#     cidr_block = "10.0.0.16/28"
#     availability_zone = "${var.availability_zone.a}"
#     tags = {
#       name = "dbSubnet-1"
#       env = "dev"
#       author = "terraform"
#     }
# }

# resource "aws_subnet" "dbSubnet-2" {
#     vpc_id = "${aws_vpc.myVpc.id}"
#     cidr_block = "10.0.0.32/28"
#     availability_zone = "${var.availability_zone.c}"

#     tags = {
#       name = "dbSubnet-2"
#       env = "dev"
#       author = "terraform"
#     }
# }

# resource "aws_db_subnet_group" "dbSubnetGroup" {
#     name        = "dbsubnetgroup"
#     subnet_ids  = ["${aws_subnet.dbSubnet-1.id}", "${aws_subnet.dbSubnet-2.id}"]

#     tags = {
#       name = "dbSubnetGroup"
#       env = "dev"
#       author = "terraform"
#     }
# }

# resource "aws_security_group" "dbSg" {
#     name = "dbSecurityGroup"
#     vpc_id = "${aws_vpc.myVpc.id}"
#     ingress {
#         from_port = 3306
#         to_port = 3306
#         protocol = "tcp"
#         cidr_blocks = ["10.0.0.0/24"]
#     }

#     egress {
#         from_port = 0
#         to_port = 0
#         protocol = "-1"
#         cidr_blocks = ["0.0.0.0/0"]
#     }

#     tags = {
#       name = "dbSecurityGroup"
#       env = "dev"
#       author = "terraform"
#     }
# }

# resource "aws_db_instance" "dbInsrance-1" {
#   allocated_storage    = 10
#   engine               = "mysql"
#   engine_version       = "5.7"
#   instance_class       = "db.t3.micro"
#   name                 = "mydb"
#   username             = "foo"
#   password             = "foobarbaz"
#   parameter_group_name = "default.mysql5.7"
#   vpc_security_group_ids = ["${aws_security_group.dbSg.id}"]
#   db_subnet_group_name = "${aws_db_subnet_group.dbSubnetGroup.name}"
#   skip_final_snapshot  = true

#     tags = {
#       name = "dbInsrance-1"
#       env = "dev"
#       author = "terraform"
#     }
# }

# // policy, cors の設定が必要
# resource "aws_s3_bucket" "bucket" {
#     bucket = "tfbucketmcdlknvejk8u"
#     acl = "private"

#     tags = {
#       name = "bucket"
#       env = "dev"
#       author = "terraform"
#     }
# }