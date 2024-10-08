# Private EC2 Instances
output "ec2_private_instance_ids" {
  description = "List of IDs of instances"
  value       = [for ec2private in module.ec2_private : ec2private.id]
}

output "ec2_private_ip" {
  description = "List of private IP addresses assigned to the instances"
  value       = [for ec2private in module.ec2_private : ec2private.private_ip]
}