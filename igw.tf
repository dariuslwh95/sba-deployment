resource "aws_internet_gateway" "epsilon-vpc-igw" {
  vpc_id = "${aws_vpc.epsilon-vpc.id}"
  tags ={
    Name = "epsilon-vpc-igw"
  }
}
resource "aws_eip" "nat_eip" {
  vpc        = true
  depends_on = [aws_internet_gateway.ig]
}
/* NAT */
resource "aws_nat_gateway" "nat" {
  allocation_id = "${aws_eip.nat_eip.id}"
  subnet_id     = "${aws_subnet.public_subnet.id}"
  depends_on    = [aws_internet_gateway.epsilon-vpc-igw]
  tags = {
    Name        = "nat"
  }
}