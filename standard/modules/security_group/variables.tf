variable "inbound_ports" {
  description = "Ingress Port"
  type = list(object({
    port     = number
    protocol = string
  }))
  default = [{
    port     = 0
    protocol = "-1"
  }]
}

variable "vpc_cidr_blocks" {
  description = "CIDR block"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "security_group_name" {
  type        = string
  description = "Sercurity group name"
  default     = "example"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "description" {
  type        = string
  description = "Sercurity group description"
  default     = null
}

variable "inbound_security_groups" {
  type        = set(string)
  description = "Sercurity groups"
  default     = null
}

variable "tags" {
  type        = map(string)
  description = "Local tags"
  default = {
    Owner = "Ngoc"
    Name  = "example-security-group"
  }
}
