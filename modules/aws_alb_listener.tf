resource "aws_alb_listener" "alb" {
  load_balancer_arn = "${aws_alb.alb.arn}"
  port              = "80"
  protocol          = "HTTP"
#   ssl_policy        = "ELBSecurityPolicy-2015-05"
#   certificate_arn   = "${var.alb_config["certificate_arn"]}"

  default_action {
    target_group_arn = "${aws_alb_target_group.albTargetGroup.arn}"
    type             = "forward"
  }
}