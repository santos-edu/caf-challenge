locals {
  region             = "us-east-2"
  availability_zones = ["${local.region}a", "${local.region}b", "${local.region}c"]
}

module "network" {
  source               = "../../modules/network"
  region               = local.region
  vpc_cidr             = "10.0.0.0/16"
  private_subnets_cidr = ["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24"]
  public_subnets_cidr  = ["10.0.100.0/24", "10.0.101.0/24", "10.0.102.0/24"]
  availability_zones   = local.availability_zones
  domain               = "lab.eduardo-santos.click"
  tags = {
    TEST-CASE = "eduardo.santos"
  }
}
