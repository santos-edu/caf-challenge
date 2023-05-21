locals {
    repo_list = [
        "result",
        "vote",
        "worker"
    ]
}

provider "aws" {
  alias  = "us-east-1"
  region = "us-east-1"
}

module "repo" {
    for_each = toset(local.repo_list)
    providers = {
      aws = aws.us-east-1
    }
    source   = "../../modules/registry"
    app_name = each.value
    private  = false
}

output "module_outputs" {
  description = "All of outputs for the repository created."
  value       = module.repo
}