
resource "aws_vpc" "epsilon-vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
    tags = {
    Name = "epsilon-vpc"
  }
}
resource "aws_internet_gateway" "epsilon-vpc-igw" {
  vpc_id = aws_vpc.epsilon-vpc.id
  tags ={
    Name = "epsilon-vpc-igw"
  }
}
resource "aws_route_table" "epsilon-vpc-rt-pb" {
  
  vpc_id = aws_vpc.epsilon-vpc.id
  route{
      cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.epsilon-vpc-igw.id
  }
  tags ={
    Name = "epsilon-vpc-rt-pb"
  }
}
