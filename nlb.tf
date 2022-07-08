
resource "aws_lb" "epsilon-lb" {
  name               = "epsilon-lb"
  internal           = false
  load_balancer_type = "network"
  # availability_zone = ["us-east-1a"]
  # subnets = [aws_subnet.epsilon-vpc-pb-1a.aws_subnet.epsilon-vpc-pb-1a.id]
  subnets            = ["${aws_subnet.epsilon-vpc-pb-1a.id}", "${aws_subnet.epsilon-vpc-pb-1b.id}" ]

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
  vpc_id   = "${aws_vpc.epsilon-vpc.id}"
}

resource "aws_lb" "epsilon-lb-api" {
  name               = "epsilon-lb-api"
  internal           = false
  load_balancer_type = "network"
  # availability_zone = ["us-east-1a"]
  # subnets = [aws_subnet.epsilon-vpc-pb-1a.aws_subnet.epsilon-vpc-pb-1a.id]
  subnets            = ["${aws_subnet.epsilon-vpc-pb-1a.id}", "${aws_subnet.epsilon-vpc-pb-1b.id}" ]

}
resource "aws_lb_listener" "epsilon-lb-api" {
  load_balancer_arn = aws_lb.epsilon-lb-api.arn
  port              = "80"
  protocol          = "TCP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.epsilon-tg-api.arn
  }
}
resource "aws_lb_target_group" "epsilon-tg-api" {
  name     = "epsilon-tg-api"
  port     = 80
  protocol = "TCP"
  vpc_id   = "${aws_vpc.epsilon-vpc.id}"
}


output "App_Endpoint" {
  value = "${aws_lb.epsilon-lb.dns_name}"
}