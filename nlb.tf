
resource "aws_lb" "epsilon-lb" {
  name               = "epsilon-lb"
  internal           = false
  load_balancer_type = "network"
  # availability_zone = ["us-east-1a"]
  # subnets = [aws_subnet.epsilon-vpc-pb-1a.aws_subnet.epsilon-vpc-pb-1a.id]
  subnets            = ["${aws_subnet.public_subnet.id}"]

}
resource "aws_lb_listener" "epsilon-lb" {
  load_balancer_arn = aws_lb.epsilon-lb.arn
  port              = "80"
  protocol          = "TCP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.epsilon-tg.arn
  }
}
resource "aws_lb_target_group" "epsilon-tg" {
  name     = "epsilon-tg"
  port     = 80
  protocol = "TCP"
  vpc_id   = "${aws_subnet.epsilon-vpc.id}"
}
