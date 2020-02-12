variable "access_key" {
  description = "Access Key ID of IAM User"
}

variable "secret_key" {
  description = "Secret Key of IAM User"
}

variable "name" {
  description = "Name of the instance."
}

variable "type" {
  description = "Type i.e. Master or Slave"
}

variable "environment" {
  description = "Enviroment of the instance. i.e. Dev, QA or Prod"
}

variable "role" {
  description = "Role of the instance."
}

variable "user" {
  description = "User to login to the created instance."
}

variable "private_key_path" {
  description = "Path for Private Key"
}
