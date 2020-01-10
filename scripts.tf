resource "null_resource" "custodian_initialization_function" {
  depends_on = [template_dir.lambda]
  triggers = {
    build_number = timestamp()
  }
  provisioner "local-exec" {
    working_dir = path.module
    command     = "./scripts/init.sh"
  }
}

resource "null_resource" "sqs_lambda_functions" {
  depends_on = [template_dir.lambda]
  triggers = {
    build_number = timestamp()
  }
  provisioner "local-exec" {
    working_dir = path.module
    command     = "./scripts/zip_files.sh"
  }
}
