# printing public ip address in console
output "web_instance_ip" {
  value = aws_instance.web.public_ip
}
