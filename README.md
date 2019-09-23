# <a name="top">GRACE Cloud Custodian Implementation</a>

## <a name="description">Description</a>
The code provided within this subcomponent will create the AWS resource required for the implementation of several policies utilizing the [Cloud Custodian](https://cloudcustodian.io) serverless rules engine. Cloud Custodian is an open source tool developed by Capital One to help provide automated governance, security, compliance, and cost optimization to their cloud environments. The grace-cloudcustodian subcomponent focuses on providing policies around IAM user managment and helps to cover several Security Controls dealing with Identification and Authentication.

>NOTE: Additional information reagarding the usage and configuration of Cloud Custodian can be found [here](https://github.com/cloud-custodian/cloud-custodian)

## <a name="contents">Table of Contents</a>

- [Description](#description)
- [Diagram](#diagram)
- [Policies](#policies)
- [Inputs](#inputs)
- [Deployment Guide](#guide)
- [Security Compliance](#security)
- [Public Domain](#license)

## <a name="diagram">Diagram</a>
![grace-cloudcustodian layout](http://www.plantuml.com/plantuml/proxy?cache=no&fmt=svg&src=https://raw.github.com/GSA/grace-cloudcustodian/master/res/diagram.uml)

[top](#top)

## <a name="policies">Policies</a>

| Name | Description | Schedule | 
|------|-------------|----------|
| iam-user-keys-expiration | Notifies IAM users with AWS Access Keys older than 80 days  | Daily |
| iam-user-keys-disable | Deletes IAM user AWS Access Keys older than 90 days  | Daily |
| iam-user-mfa-false | Notifies IAM users that have not activated MFA after 24 hours  | Daily |
| iam-user-password-expiration | Notifies IAM users with passwords older than 80 days  | Daily |
| iam-user-password-disable | Deletes console access for IAM users with passwords older than 90 days  | Daily |
| iam-new-user-initial-password-expire | Deletes console access and access keys for IAM users that have not changed their initial temporary password within 24 hours  | Daily |


[top](#top)

## <a name="input">Inputs</a>

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| sender | \(required\) The eMail address of sender for AWS SES | string | n/a | yes |
| schedule | \(required\) The frequency at which custodian policy is ran to check for compliance | string | `"rate(1 day)"` | yes |
| s3_bucket | \(required\) S3 bucket name/id where config service histories and snapshots are saved | string | n/a | yes |
| appenv | \(optional\) The environment in which the script is running (development, test, production) | string | `"development"` | no |
| kms_key_arn | \(required\) ARN of KMS key to decrypt config service histories and snapshots | string | n/a | yes |
| recipient | \(required\) The email address for aws account holder | string | `"grace-dev-alerts"` | yes |
| mfa_false_template | \(required\) The SES template name of MFA false | string | `"MFAFalse"` | yes |
| key_expiration_template | \(required\) The SES template name of AccessKey Expiration | string | `"KeyExpiration"` | yes |
| password_expiration_template | \(required\) The SES template name of Password Expiration | string | `"PasswordExpiration"` | yes |

[top](#top)

## <a name="guide">Deployment Guide</a>

* Dependencies
    - Terraform (minimum version v0.10.4; recommend v0.12.6 or greater)
        - provider.aws ~v2.24.0
        - provider.template ~v2.1.2

* Usage

## <a name="security">Security Compliance</a>
The GRACE Cloud Custodian subcomponent provides various levels of coverage for several [NIST Special Publication 800-53 (Rev. 4) Security Controls](https://nvd.nist.gov/800-53/Rev4/impact/moderate).  These security controls are designated for [FIPS 199 Moderate Impact Systems](https://nvlpubs.nist.gov/nistpubs/FIPS/NIST.FIPS.199.pdf). Additional information regarding the implementation method utilized can be found within the [GRACE Component Control Coverage Repository](https://github.com/GSA/grace-ssp/blob/master/README.md).

**Subcomponent approval status:** `Pending Assessment`

**Relevant controls:** 

| Control Description | Control ID |
|-|:-:|
| Identification and Authentication Controls | [IA-5](https://nvd.nist.gov/800-53/Rev4/control/IA-5), [IA-5(1)](https://nvd.nist.gov/800-53/Rev4/control/IA-5#enhancement-1) |

[top](#top)

## <a name="license">Public domain</a>

This project is in the worldwide [public domain](LICENSE.md). As stated in [CONTRIBUTING](CONTRIBUTING.md):

> This project is in the public domain within the United States, and copyright and related rights in the work worldwide are waived through the [CC0 1.0 Universal public domain dedication](https://creativecommons.org/publicdomain/zero/1.0/).
>
> All contributions to this project will be released under the CC0 dedication. By submitting a pull request, you are agreeing to comply with this waiver of copyright interest.
