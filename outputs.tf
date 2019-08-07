output "demo-server-ip" {
    value = "${module.server.instance_public_ip}"
}