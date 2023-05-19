
variable "ec2_ami" {
  type    = string
  default = "ami-014d05e6b24240371"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "instance_count" {
  type    = number
  default = 1
}

variable "subnet_id" {
  type = string
}

variable "security_group_ids" {
  type = set(string)
}

variable "key_pem_name" {
  type    = string
  default = null
}

variable "user_data" {
  type    = any
  default = null
}

variable "tags" {
  type        = map(string)
  description = "Local tags"
  default = {
    Owner = "Ngoc"
    Name  = "example-ec2"
  }
}
