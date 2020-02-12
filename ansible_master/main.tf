provider "aws" {
  region     = "us-east-1"
  access_key = var.access_key
  secret_key = var.secret_key
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

resource "aws_security_group" "ansible_master_sg" {
  name        = "Ansible Master Security Group"
  description = "Security Group Rules For Ansible Master"

  ingress {
    from_port   = 22
    protocol    = "TCP"
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "ansible_master" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  availability_zone           = "us-east-1b"
  tenancy                     = "default"
  key_name                    = "demokey"

  tags = {
    Name          = var.name
    "Type"        = var.type
    "Environment" = var.environment
    "Role"        = var.role
  }

  vpc_security_group_ids = [
    aws_security_group.ansible_master_sg.id
  ]

  provisioner "file" {
    source      = "script"
    destination = "/tmp"

    connection {
      type        = "ssh"
      user        = var.user
      host        = self.public_ip
      private_key = file(var.private_key_path)
    }
  }

  provisioner "remote-exec" {
    inline = [
      "sudo chmod 0755 /tmp/script/setup.sh",
      "sudo bash /tmp/script/setup.sh",
    ]
    connection {
      type        = "ssh"
      user        = var.user
      host        = self.public_ip
      private_key = file(var.private_key_path)
    }
  }

  provisioner "local-exec" {
    command = "sleep 60 && ANSIBLE_HOST_KEY_CHECKING=false ansible-playbook playbook/run-setup.yml -i '${self.public_ip},' -e ansible_user=${var.user} --private-key '${var.private_key_path}'"
  }
}
