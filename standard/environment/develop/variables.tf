variable "ec2_inbound_ports" {
  description = "Ingress Port"
  type = list(object({
    port     = number
    protocol = string
  }))
  default = [
    {
      port     = 80
      protocol = "tcp"
    },
    {
      port     = 443
      protocol = "tcp"
    }
  ]
}
