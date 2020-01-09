data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

locals {
  kms_key_arn = "arn:aws:kms:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:key/${var.kms_key_id}"
}
