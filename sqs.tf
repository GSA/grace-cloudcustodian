resource "aws_sqs_queue" "cc_queue" {
  name = "Cloud_Custodian_SQS"

  tags = {
    Name = "Cloud Custodian"
  }
  kms_master_key_id = var.kms_key_id
}
