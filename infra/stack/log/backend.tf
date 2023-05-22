terraform {
  backend "s3" {
    encrypt = true
    bucket  = "698276528129-terraform-state"
    key     = "log/terraform.tfstate"
    region  = "us-east-2"
  }
}