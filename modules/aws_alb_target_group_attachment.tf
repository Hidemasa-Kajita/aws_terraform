resource "aws_alb_target_group_attachment" "alb" {
  for_each = aws_instance.webInstance
  target_group_arn = "${aws_alb_target_group.albTargetGroup.arn}"
  target_id = each.value.id
  port             = 80
}