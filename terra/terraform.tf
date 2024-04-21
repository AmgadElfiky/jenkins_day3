# region
provider "aws" {
  region = "us-east-1"
}
resource "aws_vpc" "vpc1" {
  cidr_block = var.aws_vpc

  tags = {
    Name = "vpc1"
  }
}

# internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc1.id

  tags = {
    Name = "vpc_igw"
  }
}
z
# subnet
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.vpc1.id
  cidr_block              = var.aws_subnet
  map_public_ip_on_launch = true
  availability_zone       = var.AZ

  tags = {
    Name = "public-subnet"
  }
}

# route table
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc1.id

  route {
    cidr_block = var.CIDR_block_route
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public_rt"
  }
}

# conncetion
resource "aws_route_table_association" "public_rt_asso" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

################################SG############################
# security group
resource "aws_security_group" "securityGroup" {
  vpc_id = aws_vpc.vpc1.id

  ingress {
    description = "HTTP from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPs from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
