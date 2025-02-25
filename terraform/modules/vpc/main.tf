# Define the VPC
resource "aws_vpc" "tm_app_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = var.vpc_name
  }
}

# Define Public Subnets
resource "aws_subnet" "public_tm_app_subnets" {
  count             = length(var.public_subnet_cidrs)
  vpc_id            = aws_vpc.tm_app_vpc.id
  cidr_block        = var.public_subnet_cidrs[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = {
    Name = "${var.vpc_name}-public-subnet-${count.index + 1}"
  }
}

# Define Internet Gateway
resource "aws_internet_gateway" "tm_app_igw" {
  vpc_id = aws_vpc.tm_app_vpc.id

  tags = {
    Name = "${var.vpc_name}-igw"
  }
}

# Define Route Table for Public Subnets
resource "aws_route_table" "tm_app_route_table" {
  vpc_id = aws_vpc.tm_app_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tm_app_igw.id
  }

  tags = {
    Name = "${var.vpc_name}-public-route-table"
  }
}

# Associate Public Subnets with Route Table
resource "aws_route_table_association" "tm_app_subnet_route_association" {
  count          = length(aws_subnet.public_tm_app_subnets)
  subnet_id      = aws_subnet.public_tm_app_subnets[count.index].id
  route_table_id = aws_route_table.tm_app_route_table.id
}

