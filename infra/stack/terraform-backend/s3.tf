data "aws_caller_identity" "current" {}

resource "aws_s3_bucket" "tf_backend" {
  bucket = "${data.aws_caller_identity.current.account_id}-terraform-state"
  tags = {
    TEST-CASE = "eduardo.santos"
    Terraform = true
  }
}

resource "aws_s3_bucket_ownership_controls" "tf_backend" {
  bucket = aws_s3_bucket.tf_backend.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "tf_backend" {
  depends_on = [aws_s3_bucket_ownership_controls.tf_backend]

  bucket = aws_s3_bucket.tf_backend.id
  acl    = "private"
}
