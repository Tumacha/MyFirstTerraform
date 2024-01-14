# Resource: EC2 Instance
resource "aws_instance" "myec2vm" {
  ami                    = "ami-079db87dc4c10ac91"
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  associate_public_ip_address = true
  user_data              = file("${path.module}/app1-install.sh")
  tags = {
    "Name" = "EC2 Demo"
  }
}
