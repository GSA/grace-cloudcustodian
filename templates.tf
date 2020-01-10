resource "template_dir" "policy" {
  source_dir      = "${path.module}/custodian_policy_templates"
  destination_dir = "${path.module}/policies"

  vars = {
    cc_role                      = aws_iam_role.cc_role.arn
    cc_sqs                       = aws_sqs_queue.cc_queue.id
    cc_schedule                  = var.schedule
    cc_excluded_tag              = var.excluded_tag
    cc_excluded_value            = var.excluded_value
    recipient                    = var.recipient
    sender                       = var.sender
    key_expiration_template      = var.key_expiration_template
    mfa_false_template           = var.mfa_false_template
    password_expiration_template = var.password_expiration_template
    temp_pass_template           = var.temp_pass_template
  }
}

resource "template_dir" "lambda" {
  source_dir      = "${path.module}/lambda_templates"
  destination_dir = "${path.module}/lambda"

  vars = {
    cc_sqs = aws_sqs_queue.cc_queue.id
  }
}
