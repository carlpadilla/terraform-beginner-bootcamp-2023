# Terraform Beginner Bootcamp 2023

## Table of Contents
- [Semantic Versioning](#semantic-versioning)
- [Setting Up Terraform CLI](#setting-up-terraform-cli)
  - [Updates in Terraform CLI Installation](#updates-in-terraform-cli-installation)
  - [Compatibility Note](#compatibility-note)
  - [Streamlining Installation with Bash Scripts](#streamlining-installation-with-bash-scripts)
  - [Gitpod Lifecycle: Key Stages](#gitpod-lifecycle-key-stages)
- [Environment Variables (Env Vars)](#environment-variables-env-vars)
  - [Listing and Filtering Env Vars](#listing-and-filtering-env-vars)
  - [Setting and Clearing Env Vars](#setting-and-clearing-env-vars)
  - [Displaying Variables](#displaying-variables)
  - [AWS CLI Installation](#aws-cli-installlation)
- [Terraform Basics](#terraform-basics)
  - [Terraform Registry](#terraform-registry)
  - [Terraform Console](#terraform-console)
  - [Terraform Lock Files](#terraform-lock-files)
  - [Terraform State Files](#terraform-state-files)
- [Issues with Terraform Cloud Login and Gitpod Workspace](#issues-with-terraform-cloud-login-and-gitpod-workspace)

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

Use AWS IAM to generate a user to access AWS CLI


# Terraform Basics

### Terraform Registry

Terraform sources its providers and modules from the Terraform registry, located at [registry.terraform.io](https://registry.terraform.io/).

- **Providers** are interfaces to APIs that allow you to create resources in Terraform.
- **Modules** are a means to make large amounts of Terraform code modular, portable, and shareable.

## Terraform Console

You can view a list of all Terraform commands by typing `terraform`.

#### Terraform Init

At the start of a new Terraform project, run `terraform init` to download the necessary binaries for the Terraform providers you'll be using.

#### Terraform Plan
`terraform plan`

This command generates a changeset describing the current state of our infrastructure and the intended modifications. You can output this changeset, referred to as a "plan", for use in an apply action. However, it's often unnecessary to output it.

#### Terraform Apply
`terraform apply`

This command runs a plan and passes the changeset to Terraform for execution. It will prompt you with a 'yes' or 'no' choice. 

To automatically approve an apply action, use the `--auto-approve` flag: `terraform apply --auto-approve`.

#### Terraform Destroy
`terraform destroy`

This command is used to remove the Terraform-managed infrastructure. It will display a plan showing what will be destroyed and will ask for confirmation before proceeding. Exercise caution when using this command as it will remove resources.

To automatically approve a destroy action and bypass the confirmation prompt, use the `--auto-approve` flag: `terraform destroy --auto-approve`.


#### Terraform Lock Files

Terraform introduces dependency lock files to give users more control over which provider versions are used during operations. The lockfile, named `.terraform.lock.hcl`, is created automatically the first time you run `terraform init`. It ensures consistent provider usage across multiple team members and different environments.

To update the lock file after making changes to your configuration or to upgrade to newer versions of your providers, you can use the command `terraform providers lock`.

The Terraform Lock File should be  committed to your Version COntrol System (VSC). Github

#### Terraform State Files

Terraform maintains a record of your infrastructure in what's known as a state file (`terraform.tfstate`). This file maps real-world resources to your configuration, keeps track of metadata, and improves performance for larger infrastructures. 

Always handle state files with care:

- Never manually edit them, they are meant to be managed by Terraform itself.
- Consider storing them remotely, especially for team environments. Terraform offers state file storage through backends like AWS S3, Google Cloud Storage, and others.
- Regularly back up your state files. In case of accidental deletion or corruption, having a backup can save you a lot of headaches.



## Issues with Terraform Cloud Login and Gitpod Workspace

When attempting to run `terraform login`, it launches a WYSIWYG (What You See Is What You Get) view to generate a token. However, it does not always work as expected in Gitpod's VSCode on the browser. Note that this issue can occur, but it doesn't always happen.

The workaround is to manually generate a token in Terraform Cloud:

```
https://app.terraform.io/app/settings/tokens
```

Then, create the file manually using the following commands:

```
touch /home/gitpod/.terraform.d/credentials.tfrc.json
open /home/gitpod/.terraform.d/credentials.tfrc.json
```

After creating the file, provide the necessary code, making sure to replace your token in the file.

```json
{
  "credentials": {
    "app.terraform.io": {
      "token": "TOKEN_HERE"
    }
  }
}
```


We have automated the process using a workaround with following bash script [bin/generate_tfrc_creds](bin/generate_tfrc_creds)



# week 1 - building

## Root Module Structure

Our root module structure is as follows:

```
- PROJECT_ROOT
  - variables.tf - stores the structure of input variables
  - main.tf - everything else
  - providers.tf - defined required providers and their configuration
  - outputs.tf - stores our outputs
  - terraform.tfvars - the data of variables we want to load into our terraform project
  - README.md - required for root modules

```

[Standard Module Structure](https://developer.hashicorp.com/terraform/language/modules/develop/structure)

## Terraform and Input Variables

### Terraform Cloud Variables

In Terraform, we can define two types of variables:

- Environment Variables: These are typically set in your Bash terminal, for example, AWS credentials.
- Terraform Variables: These are variables that are commonly set in your `.tfvars` file.

Terraform Cloud allows us to mark Terraform Variables as sensitive, ensuring they are not displayed in the Terraform Cloud UI.

### Loading Terraform Input Variables

To load Terraform input variables, we have a couple of options:

### Using the `-var` Flag

You can use the `-var` flag to set an input variable or override a variable defined in the `.tfvars` file. For example:

```shell
terraform -var user_uuid="your-id"
```

### Using the `-var-file` Flag

You can use the `-var-file` flag to specify a separate variable file that contains variable values. For instance:

```shell
terraform -var-file="custom.tfvars"
```

### Using `terraform.tfvars`

Alternatively, you can define variables in a file named `terraform.tfvars`. Terraform will automatically load variable values from this file if it exists in the same directory as your Terraform configuration files.

Make sure to use the appropriate method based on your requirements and best practices for managing input variables in Terraform.

### Order of Terraform Variables

The order in which Terraform variables are applied is important for understanding how variable values are resolved and used in your Terraform configuration. The order of precedence for Terraform variables is as follows:

1. **Environment Variables**: Environment variables, if set in your Bash terminal or system environment, take the highest precedence and are usually used for sensitive information like API keys and access credentials.

2. **Command-Line Flags (`-var` and `-var-file`)**: Variables set using command-line flags like `-var` and `-var-file` can override values defined in `.tfvars` files or the `terraform.tfvars` file. These allow for dynamic input during Terraform execution.

3. **Variable Definitions in `.tfvars` Files**: Values defined in `.tfvars` files are used as the default values for your variables. Multiple `.tfvars` files can be used, and their values will be merged according to the order in which they are specified.

4. **`terraform.tfvars`**: If present in the same directory as your Terraform configuration files, the `terraform.tfvars` file is automatically loaded and used as a source of variable values. This file provides a convenient way to define default values for variables.

5. **Variable Defaults in the Configuration**: If no values are provided through the methods mentioned above, Terraform will use default values defined within the Terraform configuration itself. These defaults are specified in the variable declarations.

Understanding the order of Terraform variables helps you manage and control how input values are applied to your infrastructure deployments and ensures that you can configure your resources according to your specific needs.


## Dealing with Configuration Drift

When managing infrastructure with Terraform, it's crucial to address configuration drift. Configuration drift occurs when the actual state of your infrastructure diverges from the desired state specified in your Terraform code. This can happen for various reasons, including manual changes made to cloud resources outside of Terraform.

### Fix Missing Resources with Terraform Import

[Terraform Import](https://developer.hashicorp.com/terraform/cli/import) is a powerful tool for addressing configuration drift. It allows you to bring existing resources under Terraform management. Here's how you can use it:

1. **Identify Drifted Resources**: First, identify the resources that have drifted from your Terraform-managed infrastructure. You can do this by comparing the state of your infrastructure with your Terraform code.

2. **Create Terraform Configuration**: For each drifted resource, create a corresponding Terraform configuration block in your code, specifying its attributes and settings. Ensure that the resource block matches the existing resource as closely as possible.

3. **Use `terraform import`**: Run the `terraform import` command to import the existing resource into your Terraform state. For example:

   ```bash
   terraform import aws_instance.example i-0123456789abcdef0
   ```

   Here, `aws_instance.example` is the Terraform resource block you've defined in your configuration, and `i-0123456789abcdef0` is the existing resource's identifier.

4. **Update Terraform Code**: After importing, review your Terraform code to make any necessary adjustments, such as modifying attributes or dependencies, to match the imported resource.

5. **Apply Changes**: Run `terraform apply` to apply the changes and ensure that your infrastructure is in the desired state.

### Fix Manual Configuration

In some cases, manual modifications may occur through ClickOps or direct changes to cloud resources outside of Terraform's control. To address this:

- **Regularly Review State**: Periodically review the Terraform state to identify discrepancies between the actual cloud resources and the Terraform-managed state.

- **Terraform Plan**: Before making changes to your infrastructure, always run `terraform plan`. This command will detect differences between your code and the current state, allowing you to assess and plan for necessary adjustments.

- **Terraform Apply**: After reviewing the plan, use `terraform apply` to make changes and bring the infrastructure back into the expected state, effectively fixing any configuration drift.

## Terraform Modules

### Module Sources

Terraform modules are reusable units of Terraform configuration that allow you to encapsulate and abstract resources, making it easier to manage infrastructure as code. Modules help promote code reusability and maintainability by encapsulating specific functionality or resources within a separate directory structure.

Module sources refer to the locations from which you can source modules in your Terraform configurations. Here are some common sources for Terraform modules:

1. **Local Path**: You can define a module source using a local file path. This is helpful when you have module configurations stored locally on your file system. For example:

   ```hcl
   module "my_module" {
     source = "./path/to/my_module"
   }
   ```

2. **GitHub**: You can source modules directly from GitHub repositories by specifying the GitHub URL. This allows you to reuse publicly available modules. For example:

   ```hcl
   module "example" {
     source = "github.com/username/repo-name"
   }
   ```

3. **Git Repositories**: You can also use modules from Git repositories (public or private) by specifying the Git URL. For example:

   ```hcl
   module "example" {
     source = "git::https://git.example.com/repo.git"
   }
   ```

4. **Terraform Registry**: The [Terraform Registry](https://registry.terraform.io) is a public repository of pre-built modules contributed by the community. You can source modules directly from the registry using the namespace and module name. For example:

   ```hcl
   module "example" {
     source = "namespace/module-name/registry"
   }
   ```

5. **Local Relative Paths**: If you have module configurations stored relative to your main Terraform configuration file, you can specify the source using a relative path. For example:

   ```hcl
   module "example" {
     source = "./modules/my_module"
   }
   ```

6. **Private Module Registries**: Some organizations maintain private module registries. You can specify sources from these private registries to share modules within your organization securely.

When using module sources, it's important to ensure that you have the necessary permissions and authentication to access private repositories or registries, and that the specified source path or URL is accurate and accessible. Terraform will automatically download and manage module dependencies during `terraform init` based on the specified sources.

Here's the corrected and verified information in markdown syntax:

## Working with Files in Terraform

### Fileexists function

This is a built-in Terraform function to check the existence of a file.

```tf
condition = fileexists(var.error_html_filepath)
```

[Fileexists Function Documentation](https://developer.hashicorp.com/terraform/language/functions/fileexists)

### Filemd5

This function computes the MD5 hash of a given file's contents.

[Filemd5 Function Documentation](https://developer.hashicorp.com/terraform/language/functions/filemd5)

### Path Variable

In Terraform, there's a special variable called `path` that allows us to reference local paths:
- `path.module`: Gets the path for the current module.
- `path.root`: Gets the path for the root module.

[Special Path Variable Documentation](https://developer.hashicorp.com/terraform/language/expressions/references#filesystem-and-workspace-info)

```tf
resource "aws_s3_object" "index_html" {
  bucket = aws_s3_bucket.website_bucket.bucket
  key    = "index.html"
  source = "${path.root}/public/index.html"
}
```

## Terraform Locals

Locals allow us to define local variables. They can be very useful when we need to transform data into another format or reference a variable.

```tf
locals {
  s3_origin_id = "MyS3Origin"
}
```

[Local Values Documentation](https://developer.hashicorp.com/terraform/language/values/locals)

## Terraform Data Sources

This feature allows us to source data from cloud resources. It's useful when we want to reference cloud resources without importing them.

```tf
data "aws_caller_identity" "current" {}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}
```

[Data Sources Documentation](https://developer.hashicorp.com/terraform/language/data-sources)

## Working with JSON

We use the `jsonencode` function to create the JSON policy inline in the HCL.

```tf
> jsonencode({"hello"="world"})
{"hello":"world"}
```

[Jsonencode Function Documentation](https://developer.hashicorp.com/terraform/language/functions/jsonencode)

Note: All the provided links have been verified and lead to the official Terraform documentation by HashiCorp.


### Changing the Lifecycle of resources

[Meta arguments Lifecycle](https://developer.hashicorp.com/terraform/language/meta-arguments/lifecycle)

## Terraform Data
[Terraform data](https://developer.hashicorp.com/terraform/language/resources/terraform-data)
Plain data values such as Local Values and Input Variables don't have any side-effects to plan against and so they aren't valid in replace_triggered_by. You can use terraform_data's behavior of planning an action each time input changes to indirectly use a plain value to trigger replacement.



## Provisioners

Provisioners in Terraform are used to execute scripts or commands either on the local machine running Terraform or on a remote resource. For example, an AWS CLI command can be executed on a newly created AWS EC2 instance.

HashiCorp does not recommend using provisioners for most use cases because Configuration Management tools like Ansible, Chef, or Puppet are better suited for these tasks. However, the functionality is available if needed.

[Provisioners Documentation](https://developer.hashicorp.com/terraform/language/resources/provisioners/syntax)

### Local-exec

The `local-exec` provisioner executes a command on the local machine running Terraform. It can be used for tasks such as notifying a monitoring service that an application is installed or running a local script after resource creation.

```hcl
resource "aws_instance" "web" {
  # ...

  provisioner "local-exec" {
    command = "echo The server's IP address is ${self.private_ip}"
  }
}
```

[Local-exec Documentation](https://developer.hashicorp.com/terraform/language/resources/provisioners/local-exec)

### Remote-exec

The `remote-exec` provisioner executes commands on a remote resource after it has been created. This requires setting up a connection to the resource, such as SSH for Linux servers or WinRM for Windows servers.

```hcl
resource "aws_instance" "web" {
  # ...

  # Establishes the SSH connection for remote-exec provisioners
  connection {
    type     = "ssh"
    user     = "root"
    password = var.root_password
    host     = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "sudo puppet apply",
      "consul join ${self.private_ip}",
    ]
  }
}
```

[Remote-exec Documentation](https://developer.hashicorp.com/terraform/language/resources/provisioners/remote-exec)



## For Each Expressions

`for_each` is a powerful feature in Terraform that allows you to iterate over a map or a set of strings and create multiple instances of a resource or module. This is particularly useful when you want to create similar resources without having to duplicate the configuration code for each one.

Here's a basic example of how `for_each` can be used with a set of strings:

```hcl
variable "instance_names" {
  type    = set(string)
  default = ["instance1", "instance2", "instance3"]
}

resource "aws_instance" "example" {
  for_each = var.instance_names

  # ... other configuration ...
  
  tags = {
    Name = each.key
  }
}
```

In this example, an AWS instance will be created for each name in the `instance_names` variable. The `each.key` expression refers to the current element of the set.

`for_each` can also be used with maps, where `each.key` refers to the map key and `each.value` refers to the map value:

```hcl
variable "instances" {
  type = map(object({
    ami           = string
    instance_type = string
  }))

  default = {
    "instance1" = {
      ami           = "ami-0c55b159cbfafe1f0"
      instance_type = "t2.micro"
    },
    "instance2" = {
      ami           = "ami-0c55b159cbfafe1f0"
      instance_type = "t2.small"
    }
  }
}

resource "aws_instance" "example" {
  for_each = var.instances

  ami           = each.value.ami
  instance_type = each.value.instance_type

  tags = {
    Name = each.key
  }
}
```

In this case, `for_each` iterates over the `instances` map, creating an AWS instance for each entry with the specified AMI and instance type.

`for_each` is not limited to resources; it can also be used with modules, data sources, and outputs. It's a flexible tool that can greatly simplify your Terraform configurations by reducing repetition and making them easier to maintain.

For the most up-to-date information and advanced usage examples, please refer to the official Terraform documentation on [For Expressions](https://developer.hashicorp.com/terraform/language/expressions/for).

