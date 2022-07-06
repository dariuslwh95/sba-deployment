/* Public subnet */
resource "aws_subnet" "public_subnet" {
  vpc_id                  = "${aws_vpc.epsilon-vpc.id}"
  
  cidr_block              = "${var.subnet_cidr}"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name        = "epsilon-public-subnet"
  }
}
/* Private subnet */
resource "aws_subnet" "private_subnet" {
  vpc_id                  = "${aws_vpc.vpc.id}"
  
  cidr_block              = "${var.subnet1_cidr}"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = false
  tags = {
    Name        = "epsilon-private-subnet"
  }
}