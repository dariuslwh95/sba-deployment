resource "aws_security_group" "vpc-sg-db" {
  name        = "epsilon-vpc-sg-db"
  description = "security group DB"
  vpc_id      = aws_vpc.epsilon-vpc.id
  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    description = "Allow traffic to DB"
    cidr_blocks = ["10.0.0.0/16"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "epsilon-vpc-sg-db"
  }
}

resource "aws_db_subnet_group" "db-subnet-grp" {
  name       = "epsilon-db-subnets"
  subnet_ids = ["${aws_subnet.epsilon-vpc-pvt-1a.id}", "${aws_subnet.epsilon-vpc-pvt-1b.id}" ]
  tags = {
    Name = "epsilon-db-subnets"
  }
}

resource "aws_db_instance" "postgres" {
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = "postgres"
  instance_class         = "db.t3.micro"
  identifier             = "epsilon-sba"
  db_name                = "smartbankapp"
  username               = "postgres"
  password               = "postgres"
  db_subnet_group_name   = aws_db_subnet_group.db-subnet-grp.name
  vpc_security_group_ids = [aws_security_group.vpc-sg-db.id]
  skip_final_snapshot    = "true"
  multi_az               = "true"
}
