variable "sender" {
  type        = string
  description = "(required) eMail address of sender for AWS SES"
}

variable "schedule" {
  type        = string
  description = "The frequency at which custodian policy is ran to check for compliance."
  default     = "rate(1 day)"
}

variable "appenv" {
  type        = string
  description = "(optional) The environment in which the script is running (development | test | production)"
  default     = "development"
}

variable "recipient" {
  type        = string
  description = "(required) email address for aws account holder"
}

variable "mfa_false_template" {
  type        = string
  description = "(optional) SES template name of MFA false"
  default     = "MFAFalse"
}

variable "key_expiration_template" {
  type        = string
  description = "(optional) SES template name of AccessKey Expiration"
  default     = "KeyExpiration"
}

variable "password_expiration_template" {
  type        = string
  description = "(optional) SES template name of Password Expiration"
  default     = "PasswordExpiration"
}

variable "excluded_tag" {
  type        = string
  description = "(optional) excluded user tags to not disable"
  default     = "tag:ServiceAccount"
}

variable "excluded_value" {
  type        = string
  description = "(optional) excluded users to disable"
  default     = "Excluded"
}

variable "temp_pass_template" {
  type        = string
  description = "(optional) SES template name of Temp Password Expired"
  default     = "TempPass"
}
