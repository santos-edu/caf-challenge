data "aws_vpc" "GetVPC" {
  filter {
    name   = "tag:Name"
    values = ["iac-vpc"]
  }
}

data "aws_instances" "ec2_list" {
  instance_state_names = ["running"]
}

data "aws_subnets" "public_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.GetVPC.id]
  }

  filter {
    name   = "tag:Tier"
    values = ["public"]
  }
}

data "aws_route53_zone" "public" {
  name = var.domain
}
