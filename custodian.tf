resource "aws_iam_policy" "policy" {
  name        = "Cloud_Custodian_Policy"
  description = "Cloud Custodian Policy"
  policy      = "${file("iam_policies/cc_iam_policy.json")}"
}

resource "aws_iam_role" "cc_role" {
  name = "Cloud_Custodian_Role"

  assume_role_policy = "${file("iam_policies/assumerolepolicy.json")}"

  tags = {
    Name = "Cloud Custodian"
  }
}

resource "aws_iam_policy_attachment" "attach-policy" {
  name       = "policy-attachment"
  roles      = ["${aws_iam_role.cc_role.name}"]
  policy_arn = "${aws_iam_policy.policy.arn}"
}

resource "aws_sqs_queue" "cc_queue" {
  name                      = "Cloud_Custodian_SQS"

  tags = {
    Name = "Cloud Custodian"
  }
}

resource "template_dir" "policy" {
  source_dir      = "${path.module}/custodian_policy_templates"
  destination_dir = "${path.cwd}/policies"

  vars = {
    cc_role                      = "${aws_iam_role.cc_role.arn}"
    cc_sqs                       = "${aws_sqs_queue.cc_queue.id}"
    cc_schedule                  = "${var.schedule}" 
    cc_excluded_tag              = "${var.excluded_tag}" 
    cc_excluded_value            = "${var.excluded_value}"
    recipient                    = "${var.recipient}"
    sender                       = "${var.sender}"
    key_expiration_template      = "${var.key_expiration_template}"
    mfa_false_template           = "${var.mfa_false_template}"
    password_expiration_template = "${var.password_expiration_template}"
  }
}

resource "null_resource" "custodian_initialization_function" {
  depends_on = ["template_dir.lambda"]
  triggers = {
    build_number = "${timestamp()}"
  }
  provisioner "local-exec" {
    command = "scripts/init.sh"
  }
}

resource "template_dir" "lambda" {
  source_dir      = "${path.module}/lambda_templates"
  destination_dir = "${path.cwd}/lambda"

  vars = {
    cc_sqs = "${aws_sqs_queue.cc_queue.id}"
  }
}

# SQS Lambda Function
resource "aws_iam_role" "iam_for_sqs" {
  name = "SQS-Lambda-Role"
  assume_role_policy = "${file("iam_policies/assumerolepolicy.json")}"
  tags = {
    Name = "Cloud Custodian"
  }
}

resource "aws_iam_policy" "lambda_sqs_policy" {
  name = "Lambda_SQS_Policy"
  path = "/"
  description = "IAM policy for SQS Lambda function"

  policy = "${file("iam_policies/lambda_iam_policy.json")}"
}

resource "aws_iam_role_policy_attachment" "lambda_sqs_attachment" {
  role = "${aws_iam_role.iam_for_sqs.name}"
  policy_arn = "${aws_iam_policy.lambda_sqs_policy.arn}"
}

resource "null_resource" "sqs_lambda_functions" {
  depends_on = ["template_dir.lambda"]
  triggers = {
    build_number = "${timestamp()}"
  }
  provisioner "local-exec" {
    command = "scripts/zip_files.sh"
  }
}

resource "aws_lambda_function" "sqs_mailer" {
  depends_on = ["null_resource.sqs_lambda_functions"]
  filename = "lambda/sqs_mailer.zip"
  function_name = "sqs_mailer"
  role = "${aws_iam_role.iam_for_sqs.arn}"
  handler = "sqs_mailer.lambda_handler"
  runtime = "python3.6"
  timeout = 10
  source_code_hash = "${base64sha256("lambda/sqs_mailer.zip")}"
  environment {
    variables = {
      sender = "${var.sender}"
    }
  }
}

resource "aws_lambda_event_source_mapping" "sqs_event" {
  batch_size        = 1
  event_source_arn  = "${aws_sqs_queue.cc_queue.arn}"
  enabled           = true
  function_name     = "${aws_lambda_function.sqs_mailer.arn}"
}

resource "null_resource" "cc_lambda_functions" {
  depends_on = ["template_dir.policy"]
  triggers = {
    build_number = "${timestamp()}"
  }
  provisioner "local-exec" {
    command = "scripts/run_policies.sh"
  }
}

