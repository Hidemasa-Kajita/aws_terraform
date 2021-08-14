data "aws_ssm_parameter" "amzn2_ami" {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

resource "aws_instance" "webInstance" {
  for_each      = aws_subnet.webPublicSubnet
  ami           = data.aws_ssm_parameter.amzn2_ami.value
  instance_type = "t2.micro"
  key_name      = aws_key_pair.sshKey.key_name
  vpc_security_group_ids = [
    "${aws_security_group.webSg.id}"
  ]
  subnet_id                   = each.value.id
  associate_public_ip_address = true

  tags = {
    Name      = "webInstance-${each.key}"
    Env       = "${var.env}"
    CreatedBy = "${var.created_by}"
  }
}
