/* AMI */
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

  owners = ["099720109477"] # Canonical
}

/* EC2 Instance */
resource "aws_instance" "instance" {
  ami                         = "${data.aws_ami.ubuntu.id}"
  instance_type               = "${var.instance_type}"
  subnet_id                   = "${var.instance_subnet_id}"
  key_name                    = "${var.instance_key_name}"
  vpc_security_group_ids      = ["${var.instance_security_groups}"]
  associate_public_ip_address = "${var.instance_public}"
  user_data                   = "${file("${path.module}/user_data/${var.user_data_file}")}"
  disable_api_termination     = "${var.termination_protection}"

  tags = {
    Name = "${var.prefix_tag}-${var.instance_name}"
  }

  volume_tags {
    Name = "${var.prefix_tag}-${var.instance_name}-vol"
  }

  root_block_device {
    volume_type = "${var.instance_volume_type}"
    volume_size = "${var.instance_root_volume_size}"
  }
}

/* Elastic IP */
resource "aws_eip" "instance_eip" {
  count = "${var.associate_elastic_ip ? 1 : 0}"

  vpc      = true
  instance = "${aws_instance.instance.id}"

  tags = {
    Name = "${var.prefix_tag}-${var.instance_name}-IP"
  }
}
