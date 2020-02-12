# Ansible Master

Ansible Master is to create and setup Ansible with dynamic inventory to manage AWS resources.

## How it works?

It is using Terraform which is a **infrastructure as a code** tool to provision resources on AWS then using Shell script along with Playbook to setup it.

## Things Need To Know

Your machine from where you running this project need to install below things.

1. Terraform
2. Ansible

You need to create `IAM User` with Access Key and Secret with permission that can create resources on AWS. Also, you need to create a `SSH KEY` on AWS which you will be using to login into the server.

`ansibleadmin` user will be created and will be use for ansible purpose.

[Vault Variable](playbook/roles/ansible-master-setup/vars/vault) is left unencrypted but in real after replace credentials it should be encrypted. You can use below command to do that

```
ansible-vault encrypt --vault-password-file=REPLACEWITHPASSWORDFIE playbook/roles/ansible-master-setup/vars/vault
```

## Variables

Terrform has different variables and its values can be change in [Terraform Vars](terraform.tfvars) according to your need.

| Variable Name | Description |
| --- | --- |
| access_key | Access Key ID of IAM User
| secret_key | Secret Key of IAM User
| name | Name of the instance
| type | Type i.e. Master 
| environment | Enviroment of the instance. i.e. Dev, QA or Prod
| role | Role of the instance
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

## Testing Dynamic Inventory

`ansibleadmin` user will be created with necessary setup. From ansibleadmin home directory you can run below command to test dynamic inventory

```
ansible -i ec2.py -m ping tag_Name_Ansible_Slave
```

## References

[AWS Dynamic Inventory](https://aws.amazon.com/blogs/apn/getting-started-with-ansible-and-dynamic-amazon-ec2-inventory-management/)


[Ansible Dynamic Inventory](https://docs.ansible.com/ansible/latest/user_guide/intro_dynamic_inventory.html)

[Setup Terraform](https://learn.hashicorp.com/terraform/getting-started/install.html)

[Creating IAM User](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_users_create.html#id_users_create_console)
