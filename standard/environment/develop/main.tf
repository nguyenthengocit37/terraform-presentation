

module "network" {
  source                     = "../../modules/network"
  num_private_subnets_per_az = 1
  num_public_subnets_per_az  = 1
}

module "security_group" {
  source        = "../../modules/security_group"
  vpc_id        = module.network.vpc_id
  inbound_ports = var.ec2_inbound_ports
}

module "ec2_instance" {
  source             = "../../modules/ec2_instance"
  subnet_id          = module.network.public_subnets[0]
  security_group_ids = [module.security_group.id]
  user_data          = file("../../../user_data/helloworld.sh")
}
