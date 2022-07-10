resource "aws_security_group" "lambda-vpc-sg" {
    vpc_id = aws_vpc.lambda-vpc.id

locals {
  ingress_rules = [{
    port = 443
    description = "HTTPS"
  },
  {
    port = 22
    description = "SSH"
  },
  {
    port = 80
    description = "frontend"
  },
  {
    port = 8080
    description = "apiserver"
  }]
}

dynamic "ingress" {
  for_each = local.ingress_rules

  content {
    description = ingress.value.description
    from_port = ingress.value.port
    to_port = ingress.value.port
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags={
    Name = "lambda-vpc-sg-main"
  }
}