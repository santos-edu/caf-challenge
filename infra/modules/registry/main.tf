locals {
  tags = {
    Terraform = true
  }
}

resource "aws_ecr_repository" "main" {
  count                = var.private ? 1 : 0
  name                 = var.app_name
  image_tag_mutability = var.image_tag_mutability
  tags                 = merge(local.tags, var.tags)
  image_scanning_configuration {
    scan_on_push = var.scan_on_push
  }

  dynamic "encryption_configuration" {
    for_each = var.encryption_configuration == null ? [] : [var.encryption_configuration]
    content {
      encryption_type = encryption_configuration.value.encryption_type
      kms_key         = encryption_configuration.value.kms_key
    }
  }
}

resource "aws_ecrpublic_repository" "main" {
  count           = var.private ? 0 : 1
  repository_name = var.app_name
  tags            = merge(local.tags, var.tags)
}

resource "aws_ecr_lifecycle_policy" "main" {
  count      = var.private ? 1 : 0
  repository = aws_ecr_repository.main[0].name
  policy     = var.lifecycle_policy == "" ? file("${path.module}/lifecycle-policy.json") : var.lifecycle_policy
  depends_on = [aws_ecr_repository.main, aws_ecrpublic_repository.main]
}
