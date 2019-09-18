# <a name="top">GRACE Cloud Custodian Implementation</a>[![CircleCI](https://circleci.com/gh/GSA/grace-cloudcustodian.svg?style=svg&circle-token=3ba172998300c4ff769a83484c82c8305c8357e7)](https://circleci.com/gh/GSA/grace-cloudcustodian)

## <a name="description">Description</a>
The code provided within this subcomponent will create...

## <a name="contents">Table of Contents</a>

- [Description](#description)
- [Diagram](#diagram)
- [Inputs](#inputs)
- [Outputs](#outputs)
- [Deployment Guide](#guide)
- [Security Compliance](#security)
- [Public Domain](#license)

## <a name="diagram">Diagram</a>
![grace-cloudcustodian layout](http://www.plantuml.com/plantuml/proxy?cache=no&fmt=svg&src=https://raw.github.com/GSA/grace-cloudcustodian/master/res/diagram.uml)

[top](#top)

## <a name="input">Inputs</a>

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|

[top](#top)

## <a name="output">Outputs</a>

| Name | Description |
|------|-------------|

[top](#top)

## <a name="guide">Deployment Guide</a>

* Dependencies
    - Terraform (minimum version v0.10.4; recommend v0.12.6 or greater)
        - provider.aws ~v2.24.0
        - provider.template ~v2.1.2

* Usage

## <a name="security">Security Compliance</a>

**Subcomponent approval status:** `Pending Assessment`

**Relevant controls:** 

| Control Description | Control ID |
|-|:-:|
| Access Controls | [AC-2](https://nvd.nist.gov/800-53/Rev4/control/AC-2), [AC-6(9)](https://nvd.nist.gov/800-53/Rev4/control/AC-6#enhancement-9) |

[top](#top)

## <a name="license">Public domain</a>

This project is in the worldwide [public domain](LICENSE.md). As stated in [CONTRIBUTING](CONTRIBUTING.md):

> This project is in the public domain within the United States, and copyright and related rights in the work worldwide are waived through the [CC0 1.0 Universal public domain dedication](https://creativecommons.org/publicdomain/zero/1.0/).
>
> All contributions to this project will be released under the CC0 dedication. By submitting a pull request, you are agreeing to comply with this waiver of copyright interest.
