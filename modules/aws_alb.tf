resource "aws_alb" "alb" {
  name                       = "alb"
  security_groups            = ["${aws_security_group.albSg.id}"]
  subnets                    = [
      for v in aws_subnet.webPublicSubnet : v.id
  ]
  internal                   = false
  enable_deletion_protection = false

  access_logs {
    bucket = "${aws_s3_bucket.bucket.bucket}"
  }
}