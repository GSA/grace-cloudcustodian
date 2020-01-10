###########################
# SQS Lambda Function IAM #
###########################
resource "aws_iam_role" "iam_for_sqs" {
  name               = "SQS-Lambda-Role"
  assume_role_policy = file("${path.module}/iam_policies/assumerolepolicy.json")
  tags = {
    Name = "Cloud Custodian"
  }
}

resource "aws_iam_policy" "lambda_sqs_policy" {
  name        = "Lambda_SQS_Policy"
  path        = "/"
  description = "IAM policy for SQS Lambda function"

  policy = file("${path.module}/iam_policies/lambda_iam_policy.json")
}

resource "aws_iam_role_policy_attachment" "lambda_sqs_attachment" {
  role       = aws_iam_role.iam_for_sqs.name
  policy_arn = aws_iam_policy.lambda_sqs_policy.arn
}

######################
# CloudCustodian IAM #
######################
resource "aws_iam_policy" "policy" {
  name        = "Cloud_Custodian_Policy"
  description = "Cloud Custodian Policy"
  policy      = file("${path.module}/iam_policies/cc_iam_policy.json")
}

resource "aws_iam_role" "cc_role" {
  name = "Cloud_Custodian_Role"

  assume_role_policy = file("${path.module}/iam_policies/assumerolepolicy.json")

  tags = {
    Name = "Cloud Custodian"
  }
}

resource "aws_iam_policy_attachment" "attach-policy" {
  name       = "policy-attachment"
  roles      = [aws_iam_role.cc_role.name]
  policy_arn = aws_iam_policy.policy.arn
}
