resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = "true"
  enable_dns_support   = "true"

  tags = local.tags



}


resource "aws_subnet" "public" {
  count = length(var.pub_subnets)

  vpc_id            = aws_vpc.main.id
  cidr_block        = element(concat(var.pub_subnets, [""]), count.index)
  availability_zone = element(data.aws_availability_zones.availability_zones.names, count.index)

  tags = local.tags
}


resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.main.id

  ingress = [{
      description      = "SSH from VPC"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]
  egress = [{
      description      = "SSH from VPC"
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]

  tags = local.tags
}


resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = local.tags
}


resource "aws_route_table" "main_route_table" {
  count = length(var.pub_subnets)

  vpc_id = aws_vpc.main.id

  tags = local.tags
}

resource "aws_route" "internet_gateway" {
  count = length(var.pub_subnets)

  route_table_id            = aws_route_table.main_route_table.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.gw.id
         
}