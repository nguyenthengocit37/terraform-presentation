variable "cidr_block" {
  type    = string
  default = "172.16.0.0/16"
}

variable "num_public_subnets_per_az" {
  type        = number
  description = "Number of public subnets per availability zone"
  default     = 1

  validation {
    condition     = var.num_public_subnets_per_az >= 1
    error_message = "Number of public subnets must lagger than 1"
  }
}

variable "num_private_subnets_per_az" {
  type        = number
  description = "Number of private subnets per availability zone"
  default     = 1

  validation {
    condition     = var.num_private_subnets_per_az >= 1
    error_message = "Number of private subnets must larger than 1"
  }
}

variable "availability_zones" {
  type    = set(string)
  default = ["us-west-1a", "us-west-1b"]

  validation {
    condition     = length(var.availability_zones) >= 1
    error_message = "Number of availability zones must lagger than 1"
  }
}

variable "create_internet_gateway" {
  type        = bool
  description = "Determine need to create internet gateway"
  default     = true
}

variable "newbits" {
  type        = number
  description = "New bits of cidr block"
  default     = 8
}

variable "local_tags" {
  type = object({
    Owner = string
  })

  default = {
    Owner = "Ngoc dev"
  }
}

variable "vpc_tags" {
  type = object({
    Name = string
  })

  default = {
    Name = "zigvy_vpc"
  }
}

variable "internet_gw_tags" {
  type        = map(string)
  description = "Local tags"
  default = {
    Name = "example-internet-gateway"
  }
}

variable "route_table_tags" {
  type        = map(string)
  description = "Local tags"
  default = {
    Owner = "Ngoc"
    Name  = "example-route-table"
  }
}
