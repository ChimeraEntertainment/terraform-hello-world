output "instance_public_ip" {
  value = "${aws_eip.instance_eip.*.public_ip}"
}