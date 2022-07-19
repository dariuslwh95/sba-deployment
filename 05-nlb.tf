resource "aws_lb" "lambda-lb" {
  name               = "lambda-lb"
  internal           = false
  load_balancer_type = "network"
  # availability_zone = ["us-east-2a"]
  # subnets = [aws_subnet.lambda-vpc-pb-1a.aws_subnet.lambda-vpc-pb-1a.id]
  subnets            = ["${aws_subnet.lambda-vpc-pb-1a.id}", "${aws_subnet.lambda-vpc-pb-1b.id}" ]

}
resource "aws_lb_listener" "lambda-lb" {
  load_balancer_arn = aws_lb.lambda-lb.arn
  port              = "80"
  protocol          = "TCP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lambda-tg.arn
  }
}
resource "aws_lb_target_group" "lambda-tg" {
  name     = "lambda-tg"
  port     = 80
  protocol = "TCP"
  vpc_id   = "${aws_vpc.lambda-vpc.id}"
}

resource "aws_lb" "lambda-lb-api" {
  name               = "lambda-lb-api"
  internal           = false
  load_balancer_type = "network"
  # availability_zone = ["us-east-2a"]
  # subnets = [aws_subnet.lambda-vpc-pb-1a.aws_subnet.lambda-vpc-pb-1a.id]
  subnets            = ["${aws_subnet.lambda-vpc-pb-1a.id}", "${aws_subnet.lambda-vpc-pb-1b.id}" ]

}
resource "aws_lb_listener" "lambda-lb-api" {
  load_balancer_arn = aws_lb.lambda-lb-api.arn
  port              = "80"
  protocol          = "TCP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lambda-tg-api.arn
  }
}
resource "aws_lb_target_group" "lambda-tg-api" {
  name     = "lambda-tg-api"
  port     = 80
  protocol = "TCP"
  vpc_id   = "${aws_vpc.lambda-vpc.id}"
}


output "App_Endpoint" {
  value = "${aws_lb.lambda-lb.dns_name}"
}