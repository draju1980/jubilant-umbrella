output "public_ip" {
    description = "Public IP address of demo-nginx-node"
    value = aws_instance.demo-nginx-node.public_ip
}
output "nginx_url" {
description = "Nginx URL for demo-nginx-node"
value       = "http://${aws_instance.demo-nginx-node.public_ip}/"
}
output "ssh_command" {
description = "SSH command to connect demo-nginx-node"
value       = "ssh -i ${local_sensitive_file.this.filename} ubuntu@${aws_instance.demo-nginx-node.public_ip}"
  
}
output "instance_id" {
description = "ID of the demo-nginx-node instance"
value       = aws_instance.demo-nginx-node.id
}
