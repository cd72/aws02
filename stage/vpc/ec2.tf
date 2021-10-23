resource "aws_network_interface" "nic" {
  subnet_id   = aws_subnet.public[0].id
  security_groups = [aws_security_group.allow_ssh.id]


  tags = local.tags
}

resource "aws_instance" "bastion_server" {
  ami           = "ami-0194c3e07668a7e36"
  instance_type = "t2.micro"
  #associate_public_ip_address = true
  network_interface {
    network_interface_id = aws_network_interface.nic.id
    device_index         = 0
  }
  #vpc_security_group_ids = [aws_security_group.allow_ssh.id]

  tags = merge(
      local.tags,
      { "Description": "EC2 instance on public subnet"}
  )
}
