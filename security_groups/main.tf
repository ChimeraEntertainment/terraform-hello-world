/* SSH Security Group */
resource "aws_security_group" "ssh-sg" {
  name        = "${var.prefix_tag}-ssh-sg"
  vpc_id      = "${var.vpc_id}"
  description = "SSH Security Group - allows SSH access from Workstation"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.workstation_ip}"]
    description = "WORKSTATION IP"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.prefix_tag}-ssh-sg"
  }
}

/* Server Security Group */
resource "aws_security_group" "server-sg" {
  name        = "${var.prefix_tag}-server-sg"
  vpc_id      = "${var.vpc_id}"
  description = "HTTP Security Group - allows access to Server from Workstation"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["${var.workstation_ip}"]
    description = "WORKSTATION IP"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.prefix_tag}-server-sg"
  }
}
