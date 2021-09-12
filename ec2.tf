resource "aws_instance" "bastion_server" {
  ami           = "ami-0194c3e07668a7e36"
  instance_type = "t2.micro"

  tags = merge(
      var.tags,
      { "Description": "EC2 instance on public subnet"}
  )
}