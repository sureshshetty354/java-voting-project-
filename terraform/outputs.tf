
output "ec2_instance_id" {
  description = "Voting application EC2 instance ID"
  value       = aws_instance.voting_server.id
}

output "ec2_public_ip" {
  description = "EC2 public IP address"
  value       = aws_instance.voting_server.public_ip
}

output "application_url" {
  description = "Voting application URL"
  value       = "http://${aws_instance.voting_server.public_ip}"
}

output "health_check_url" {
  description = "Application health endpoint"
  value       = "http://${aws_instance.voting_server.public_ip}/health"
}

output "ssh_command" {
  description = "SSH connection command"
  value       = "ssh -i YOUR_KEY.pem ec2-user@${aws_instance.voting_server.public_ip}"
}

