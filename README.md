# Terraform Beginner Bootcamp 2023

## Semantic Versioning

This project adheres to semantic versioning conventions. For details, refer to [semver.org](https://semver.org/).

Format: **MAJOR.MINOR.PATCH**, e.g., `1.0.1`:
- **MAJOR** - Incompatible API changes
- **MINOR** - Backward-compatible new functionalities
- **PATCH** - Backward-compatible bug fixes

## Setting Up Terraform CLI

### Updates in Terraform CLI Installation 

Due to changes in the gpg keyring, the Terraform CLI installation instructions have been updated. Please refer to the [latest installation guide](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli).

### Compatibility Note

This project is tailored for Ubuntu. Ensure your Linux Distribution is compatible by [checking your Linux OS Version](https://www.cyberciti.biz/faq/find-linux-distribution-name-version-number/).

Sample command to verify OS version:
```bash
$ cat /etc/*-release
```

### Streamlining Installation with Bash Scripts

To address the changes in Terraform CLI and to simplify the setup, a bash script has been created:

- Script Location: [./bin/install_terraform_cli](./bin/install_terraform_cli)
- Benefits:
  - Keeps the Gitpod Task File ([.gitpod.yml](.gitpod.yml)) clean
  - Facilitates easier debugging
  - Enhances portability across projects requiring Terraform CLI

### Gitpod Lifecycle: Key Stages

For details, refer to the [Gitpod lifecycle documentation](https://www.gitpod.io/docs/configure/workspaces/tasks). Note: The `init` phase in the `gitpod.yml` file won't rerun upon restarting an existing workspace.

## Environment Variables (Env Vars)

### Listing and Filtering Env Vars

To list all Env Vars:
```bash
env
```
For specific Env Vars (e.g., AWS related):
```bash
env | grep AWS_
```

### Setting and Clearing Env Vars

Set an Env Var:
```bash
export HELLO='world'
```

Unset an Env Var:
```bash
unset HELLO
```

For temporary assignment during command execution:
```bash
HELLO='world' ./bin/print_message
```

In a bash script, you can set an env var without `export`:
```bash
#!/usr/bin/env bash
HELLO='world'
echo $HELLO
```

## Displaying Variables

To display an env var:
```bash
echo $HELLO
```

#### Variable Scope

Env Vars set in one terminal won't be available in another terminal within VSCode. For persistence across terminals, set the Env Vars in your bash profile.

#### Persistent Env Vars in Gitpod

Store persistent Env Vars in Gitpod's Secret Storage:
```bash
gp env HELLO='world'
```

All subsequent workspaces will have these Env Vars available in all their terminals. For non-sensitive data, you can set Env Vars directly in `gitpod.yml`.


### AWS CLI Installlation

AWS CLI is installed for the project via the bash script [`./bin/install_aws_cli`](./bin/install_aws_cli)

[Getting Started Guide](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
[AWS Set Env Vars](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html)

We can check if our AWS credentials are configured correctly by running the following command.
```sh
aws sts get-caller-identity
```

We'll need to use AWS IAM to generate a user to access AWS CLI