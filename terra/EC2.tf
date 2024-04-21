resource "aws_instance" "web" {
  ami                         = var.ami
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.public_subnet.id
  security_groups             = [aws_security_group.securityGroup.id]
  associate_public_ip_address = true

  user_data = file("script.sh")

  tags = {
    Name = "web_instance"
  }

  volume_tags = {
    Name = "web_instance"
  }
}
