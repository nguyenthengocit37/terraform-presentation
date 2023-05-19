variable "cidr_block" {
  type    = string
  default = "172.16.0.0/16"
}

variable "region" {
  type = string
}
variable "aws_access_key_id" {
  type = string
}
variable "aws_secret_access_key" {
  type = string
}
