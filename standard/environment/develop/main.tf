

module "network" {
  source                     = "../../modules/network"
  num_private_subnets_per_az = 1
  num_public_subnets_per_az  = 1
}


module "internet_gateway" {
  source = "../../modules/internet_gateway"
  vpc_id = module.network.vpc_id
}

module "route_table" {
  source              = "../../modules/route_table"
  vpc_id              = module.network.vpc_id
  public_subnets      = module.network.public_subnets
  internet_gateway_id = module.internet_gateway.id
}

module "ec2_instance" {
  source    = "../../modules/ec2_instance"
  subnet_id = module.network.public_subnets[0]
  user_data = file("../../user_data/ubuntu.sh")
}
