output "ansible_slave_ip" {
  value = "${aws_instance.ansible_slave.public_ip}"
}
