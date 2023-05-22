variable "vpc_cidr" {
  type        = string
  description = "CIDR block of the vpc"
}

variable "private_subnets_cidr" {
  type        = list(any)
  description = "CIDR block for Private Subnet"
}

variable "public_subnets_cidr" {
  type        = list(any)
  description = "CIDR block for Public Subnet"
}

variable "region" {
  type        = string
  description = "Region in which the bastion host will be launched"
}

variable "availability_zones" {
  type        = list(any)
  description = "AZ in which all the resources will be deployed"
}

variable "tags" {
  type        = map(any)
  description = "Additional tags to apply."
  default     = {}
}

variable "domain" {
  type        = string
  description = "Domain to expose ingress"
  default     = ""
}
