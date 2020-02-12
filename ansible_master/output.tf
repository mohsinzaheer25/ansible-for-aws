output "ansible_master_ip" {
  value = "${aws_instance.ansible_master.public_ip}"
}
