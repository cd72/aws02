resource "aws_vpc" "main" {
    cidr_block = var.vpc_cidr
    instance_tenancy = "default"
    enable_dns_hostnames = "true"
    enable_dns_support = "true"

    tags = var.tags



}


resource "aws_subnet" "public" {
    count = length(var.public_subnets) 

    vpc_id = aws_vpc.this[0].vpc_id
    cidr_block = element(concat(var.pub_subnets, [""]), count.index)
    availability_zone = "${element(data.aws_availability_zones.names, count.index)}"

    tags = var.tags
}