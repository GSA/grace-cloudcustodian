resource "aws_ses_template" "mfa_false" {
  name    = "${var.mfa_false_template}"
  subject = "The MFA for the user {user_name} is not set yet!"
  html    = "<h1>Hello,</h1><p>The MFA for the user {user_name} is not set yet!</p>"
  text    = "The MFA for the user {user_name} is not set yet!"
}

resource "aws_ses_template" "key_expiration" {
  name    = "${var.key_expiration_template}"
  subject = "The Accesskey for the user {user_name} needs to be renewed!"
  html    = "<h1>Hello,</h1><p>The Accesskey for the user {user_name} needs to be renewed!</p>"
  text    = "The Accesskey for the user {user_name} needs to be renewed!"
}

resource "aws_ses_template" "password_expiration" {
  name    = "${var.password_expiration_template}"
  subject = "The password for the user {user_name} needs to be renewed!"
  html    = "<h1>Hello,</h1><p>The password for the user {user_name} needs to be renewed!</p>"
  text    = "The password for the user {user_name} needs to be renewed!"
}

resource "aws_ses_template" "temp_pass" {
  name    = "${var.temp_pass_template}"
  subject = "The temporary password for the user {user_name} has not been changed!"
  html    = "<h1>Hello,</h1><p>The temporary password for the user {user_name} has not been changed within the 24 hour period. Console access has been disabled for user {user_name}.</p>"
  text    = "The temporary password for the user {user_name} has not been changed. Console access has been disabled for user {user_name}."
}
