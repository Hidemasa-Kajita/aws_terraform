resource "aws_alb_target_group" "albTargetGroup" {
  name     = "albTargetGroup"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${aws_vpc.myVpc.id}"

  health_check {
    interval            = 30
    path                = "/index.html"
    port                = 80
    protocol            = "HTTP"
    timeout             = 5
    unhealthy_threshold = 2
    matcher             = 200
  }
}