provider "aws" {
  region     = "us-east-1"
  access_key = ""
  secret_key = ""
}

/* Creates a VPC and 2 public subnets */
module "networking" {
  source              = "./networking"
  prefix_tag          = "demo"
  vpc_cidr            = "10.10.0.0/16"
  availability_zone_1 = "us-east-1a"
  availability_zone_2 = "us-east-1b"
  sbn_cidr_1          = "10.10.1.0/24"
  sbn_cidr_2          = "10.10.2.0/24"
  ssh_key_name        = "demo-key"
  ssh_public_key      = ""
}

/* Creates Security Groups to Allow traffic */
module "security_groups" {
  source         = "./security_groups"
  prefix_tag     = "demo"
  workstation_ip = ""
  vpc_id         = "${module.networking.vpc_id}"
}

/* Creates a server with static IP */
module "server" {
  source                    = "./instances"
  prefix_tag                = "demo"
  instance_name             = "server"
  instance_type             = "t2.micro"
  instance_root_volume_size = 20
  instance_volume_type      = "gp2"
  instance_public           = true
  termination_protection    = false
  instance_subnet_id        = "${module.networking.public_demo_subnet}"
  instance_key_name         = "${module.networking.ssh_key}"
  instance_security_groups  = ["${module.security_groups.ssh-sg}", "${module.security_groups.server-sg}"]
  user_data_file            = "server.sh"
  associate_elastic_ip      = true
}
