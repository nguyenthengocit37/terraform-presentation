resource "aws_instance" "main" {
  ami           = "ami-014d05e6b24240371"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public_1.id

  security_groups = [aws_security_group.allow_http_https.id]

  key_name = "ngoc"

  user_data = file("../user_data/helloworld.sh")

  tags = {
    Name = "Instance test"
  }
}
