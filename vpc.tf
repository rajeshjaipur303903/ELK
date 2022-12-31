#basic setup
resource "aws_vpc" "elastic_vpc"{
  cidr_block = cidrsubnet("172.20.0.0/16",0,0)
  tags={
    Name="elastic_vpc"
  }
}
resource "aws_internet_gateway" "elastic_internet_gateway" {
  vpc_id = aws_vpc.elastic_vpc.id
  tags = {
    Name = "elastic_igw"
  }
}
resource "aws_route_table" "elastic_rt" {
  vpc_id = aws_vpc.elastic_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.elastic_internet_gateway.id
  }
  tags = {
    Name = "elastic_rt"
  }
}
resource "aws_main_route_table_association" "elastic_rt_main" {
  vpc_id         = aws_vpc.elastic_vpc.id
  route_table_id = aws_route_table.elastic_rt.id
}
resource "aws_subnet" "elastic_subnet"{
  for_each = {us-east-1a=cidrsubnet("172.20.0.0/16",8,10),us-east-1b=cidrsubnet("172.20.0.0/16",8,20)}
  vpc_id = aws_vpc.elastic_vpc.id
  availability_zone = each.key
  cidr_block = each.value
  tags={
    Name="elastic_subnet_${each.key}"
  }
}
variable "az_name" {
  type    = list(string)
  default = ["us-east-1a","us-east-1b"]
}


# resource "aws_key_pair" "elastic_ssh_key" {
#   key_name="tf-kp"
#   public_key= file("tf-kp.pub")
# }