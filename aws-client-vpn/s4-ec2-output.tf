
# Private EC2 Instances
## ec2_private_instance_ids
output "ec2_private_instance_ids" {
  description = "List of IDs of instances"
  value       = [for ec2private in module.ec2_private : ec2private.id]
}

# ## ec2_private_ip
output "ec2_private_ip" {
  description = "List of private IP addresses assigned to the instances"
  value       = [for ec2private in module.ec2_private : ec2private.private_ip]
}