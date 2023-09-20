# Terraform Beginner Bootcamp 2023

## Semantic Versioning

This project is going to utilize semantic versioning for its tagging.
[semver.org](https://semver.org/)

The general format: 

 **MAJOR.MINOR.PATCH**, eg. `1.0.1`:

- **MAJOR** version when you make incompatible API changes
- **MINOR** version when you add functionality in a backward compatible manner
- **PATCH** version when you make backward compatible bug fixes

## Install the Terraform CLI

### Considerations with the Terraform CLI changes
The Terraform CLI installation instrcutions have changed due to gpg keyring changes. So we needed to refer to the latest install CLI instructions via Terraform Documentation and change the scripting for the install.
[Install Terraform CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

### Consideration for Linux Distribution

This project is built against Ubuntu.
Please consider checking your Linux Distribution.

[How to check Linux OS Version](https://www.cyberciti.biz/faq/find-linux-distribution-name-version-number/)

Example of checking OS version:
```
 $ cat /etc/*-release
DISTRIB_ID=Ubuntu
DISTRIB_RELEASE=22.04
DISTRIB_CODENAME=jammy
DISTRIB_DESCRIPTION="Ubuntu 22.04.3 LTS"
PRETTY_NAME="Ubuntu 22.04.3 LTS"
NAME="Ubuntu"
VERSION_ID="22.04"
VERSION="22.04.3 LTS (Jammy Jellyfish)"
VERSION_CODENAME=jammy
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=jammy
```

### Refactoring into Bash Scripts

While fixing the Terraform CLI gpg deprecation issues we noticed that the bash scripts steps were a considerable amount of more code. So I decided to create a bash script to install the Terraform CLI.

The bash script is located at: [./bin/install_terraform_cli](./bin/install_terraform_cli)

- This will kepp the Gitpod Task File ([.gitpod.yml](.gitpod.yml)) tidy.
- This will allow us an easier easier debugging
- This will aloow better portability for other projects that need to install Terraform CLI.

### Gitpod Lifecycle (Before, Init, Commit)
https://www.gitpod.io/docs/configure/workspaces/tasks

We need to be careful when using Init in the girpod.yml file, because it will not rerun if we restart an existing workspace.
