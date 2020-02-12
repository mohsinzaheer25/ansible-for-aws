# Ansible Slave

Ansible Slave is to setup EC2 instance in order to get maintain by Ansible.

## How it works?

It is using Terraform which is a **infrastructure as a code** tool to provision resources on AWS then uses Playbook to setup it.

## Things Need To Know

Your machine from where you running this project need to install below things.

1. Terraform
2. Ansible

You need to create `IAM User` with Access Key and Secret with permission that can create resources on AWS. Also, you need to create a `SSH KEY` on AWS which you will be using to login into the server.

`ansibleadmin` user will be created and added to Sudoers file in order to have root access.

## Variables

Terrform has different variables and its values can be change in [Terraform Vars](terraform.tfvars) according to your need.

| Variable Name | Description |
| --- | --- |
| access_key | Access Key ID of IAM User
| secret_key | Secret Key of IAM User
| name | Name of the instance
| type | Type i.e. Master 
| environment | Enviroment of the instance. i.e. Dev, QA or Prod
| user | User to login to the created instance
| private_key_path | Path for Private Ke

## Provisioning Ansible Master

First, you need to replace the necessary variables in [Terraform Vars](terraform.tfvars) and then initiate terraform by using below command in order to get the appropriated plugin.

```
terraform init
```

You can check the changes Terraform is making using below command

```
terraform plan
```

Once everything looks good, you can provision the resource using below command

```
terraform apply
```

## References

[Setup Terraform] (https://learn.hashicorp.com/terraform/getting-started/install.html)

[Creating IAM User] (https://docs.aws.amazon.com/IAM/latest/UserGuide/id_users_create.html#id_users_create_console)
