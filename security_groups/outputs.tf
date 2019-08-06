output "ssh-sg" {
  value = "${aws_security_group.ssh-sg.id}"
}

output "server-sg" {
  value = "${aws_security_group.server-sg.id}"
}
