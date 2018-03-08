# output
output "1" {
	value = "${join(",", aws_instance.swarm-manager.*.public_ip)}"

}

output "workerip" {
        value = "${join(",", aws_instance.swarm-worker.*.private_ip)}"

}

output "managerip" {
        value = "${join(",", aws_instance.swarm-manager.*.private_ip)}"

}

output "manager4" {
  value = ["${aws_instance.swarm-manager.*.id}"]
}