variable "vpc_id" {
  type = string
}


variable "public_subnets" {
  type = set(string)
}

variable "internet_gateway_id" {
  description = "Internet gateway id"
  type        = string
}
