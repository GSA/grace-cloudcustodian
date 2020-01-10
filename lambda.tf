resource "aws_lambda_function" "sqs_mailer" {
  depends_on       = [null_resource.sqs_lambda_functions]
  filename         = "${path.module}/lambda/sqs_mailer.zip"
  function_name    = "sqs_mailer"
  role             = aws_iam_role.iam_for_sqs.arn
  handler          = "sqs_mailer.lambda_handler"
  runtime          = "python3.6"
  timeout          = 10
  source_code_hash = base64sha256("${path.module}/lambda/sqs_mailer.zip")
  kms_key_arn      = local.kms_key_arn
  environment {
    variables = {
      sender = var.sender
    }
  }
}

resource "aws_lambda_event_source_mapping" "sqs_event" {
  batch_size       = 1
  event_source_arn = aws_sqs_queue.cc_queue.arn
  enabled          = true
  function_name    = aws_lambda_function.sqs_mailer.arn
}

resource "null_resource" "cc_lambda_functions" {
  depends_on = [template_dir.policy]
  triggers = {
    build_number = timestamp()
  }
  provisioner "local-exec" {
    working_dir = path.module
    command     = "./scripts/run_policies.sh"
  }
}
