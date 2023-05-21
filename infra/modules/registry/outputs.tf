output "arn" {
  description = "Full ARN of the repository."
  value       = var.private ? aws_ecr_repository.main[0].arn : aws_ecrpublic_repository.main[0].arn
}

output "repo_url" {
  description = "The URL for the repository created."
  value       = var.private ? aws_ecr_repository.main[0].repository_url : aws_ecrpublic_repository.main[0].repository_uri
}
