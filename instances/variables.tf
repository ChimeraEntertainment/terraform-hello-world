variable "prefix_tag" {}
variable "instance_name" {}
variable "instance_type" {}
variable "instance_subnet_id" {}
variable "instance_key_name" {}
variable "instance_root_volume_size" {}
variable "instance_volume_type" {}

variable "instance_security_groups" {
  type = "list"
}

variable "instance_public" {
  default = false
}

variable "user_data_file" {}

variable "associate_elastic_ip" {
  default = false
}

variable "termination_protection" {
  default = false
}
