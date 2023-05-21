locals {
  deployment_name = "eduardo-santos"
}

data "aws_vpc" "vpc" {
  id = "vpc-0da0163785e22cfee"
}

resource "aws_security_group" "sg" {
  name   = "allow_all"
  vpc_id = data.aws_vpc.vpc.id
}

resource "aws_security_group_rule" "allow_all_inbound" {
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 0
  to_port           = 65535
  type              = "ingress"
  protocol          = "-1"
  security_group_id = aws_security_group.sg.id
}

resource "aws_security_group_rule" "allow_all_outbound" {
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 0
  to_port           = 65535
  type              = "egress"
  protocol          = "-1"
  security_group_id = aws_security_group.sg.id
}

module "k3s" {
  source = "../../modules/kubernetes"
  assign_public_ip          = true
  deployment_name           = local.deployment_name
  instance_type             = "t2.micro"
  security_group_ids        = [aws_security_group.sg.id]
  enable_worker_nodes       = true
  worker_node_min_count     = 3
  worker_node_max_count     = 5
  worker_node_desired_count = 3
  subnet_id                 = "subnet-0d19e5bc8c453031a"
}

output "k3s_master_public_dns" {
  value = module.k3s.instance.public_dns
}