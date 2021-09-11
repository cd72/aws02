locals {
  tags = {
    Environment = "Test"
  }
}

data "aws_availability_zones" "availability_zones" {}

variable "vpc_cidr" {
  description = "Value of the CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "pub_subnets" {
  description = "List of public subnets to be used inside of VPC"
  type        = list(string)
  default = [
    "10.0.0.0/24",
    "10.0.1.0/24"
  ]
}

variable "priv_app_subnets" {
  description = "List of public subnets to be used inside of VPC"
  type        = list(string)
  default = [
    "10.0.2.0/24",
    "10.0.3.0/24"
  ]
}

variable "priv_db_subnets" {
  description = "List of public subnets to be used inside of VPC"
  type        = list(string)
  default = [
    "10.0.4.0/24",
    "10.0.5.0/24"
  ]
}
