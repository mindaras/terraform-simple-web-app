# Terraform setup

## Prerequisites

_Export AWS keys as environment variables_

```
export AWS_ACCESS_KEY_ID=<access key>
export AWS_SECRET_ACCESS_KEY=<secret access key>
```

## Workflow commands

_Initialize Terraform configuration_

```
terraform init

// upgrade dependencies
terraform init -upgrade

// mark a resource for replacement (recreation) regardless of its status
terraform init -replace <resource type>.<resource name>
```

_Create an execution plan_

```
// output to terminal
terraform plan

// output to a file
terraform plan -out <filename>.tfplan
```

_Create the resources_

```
// runs a fresh execution plan with a prompt asking for confirmation
terraform apply "<plan-filename>"

// applies the changes in the plan
terraform apply "<plan-filename>"
```

_Destroy the resources_

```
terraform destroy
```

_See the outputs again_

```
terraform output
```

## Formatting and validation commands

_Format code_

```
terraform fmt

// checks formatting
terraform fmt -check

// formats the current directory and subdirectories
terraform fmt -recursive
```

_Validate code_

```
terraform validate
```

_Export sensitive variables as environment variables_

```
export TF_VAR_aws_access_key=<access key>
export TF_VAR_aws_secret_key=<secret key>
```

## State commands

_List all state resources_

```
terraform state list
```

_Show details about a specific resource_

```
terraform state show <resource type>.<resource name>
```

_Move an item in state_

```
terraform state mv <source> <target>
```

_Remove an item from state_

```
terraform state rm <resource type>.<resource name>
```

## Console

_Start the console (interactive environment) for testing functions and checking variable values_

```
terraform console
```

_Exit the console and release the state lock gracefully_

```
exit
```

## Troubleshooting

Some resources may fail to be deleted due to dependencies when drastic infrastructure changes are made. This usually happens because the dependencies are not exposed to Terraform. A good way to solve this is to run `terraform plan`, identify the resources that need to be changed and force replace them:

```
terraform apply -replace <resource 1> -replace <resource 2>
```
