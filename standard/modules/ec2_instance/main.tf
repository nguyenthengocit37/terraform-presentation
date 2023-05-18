
resource "aws_instance" "main" {
  count         = var.aws_instance_count
  ami           = var.ec2_ami
  instance_type = var.instance_type
  subnet_id     = var.subnet_id

  security_groups = var.security_group_ids

  key_name = var.key_pem_name || null

  user_data = var.user_data || null

  tags = {
    Name = "Instance test"
  }
}
