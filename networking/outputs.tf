output "vpc_id" {
  value = "${aws_vpc.vpc.id}"
}

output "public_demo_subnet" {
  value = "${aws_subnet.demo-public-subnet.id}"
}

output "private_demo_subnet" {
  value = "${aws_subnet.demo-private-subnet.id}"
}

output "ssh_key" {
  value = "${aws_key_pair.admin-key-pair.key_name}"
}
