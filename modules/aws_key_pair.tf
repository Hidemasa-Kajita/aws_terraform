resource "aws_key_pair" "sshKey" {
  key_name   = "key"
  public_key = file("./.ssh/key.pub")

  tags = {
    Name      = "sshKey"
    Env       = "${var.env}"
    CreatedBy = "${var.created_by}"
  }
}