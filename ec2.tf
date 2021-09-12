resource "aws_instance" "bastion_server" {
  ami           = "ami-0194c3e07668a7e36"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.allow_ssh]

  tags = merge(
      local.tags,
      { "Description": "EC2 instance on public subnet"}
  )
}