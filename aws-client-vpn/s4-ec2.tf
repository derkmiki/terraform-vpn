data "aws_ami" "amzlinux2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-*-hvm-*-gp2"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

# AWS EC2 Security Group Terraform Module
# Security Group for Private EC2 Instances
module "private_sg" {
  source = "terraform-aws-modules/security-group/aws"
  #version = "3.18.0"
  version = "5.1.0"

  name        = "private-sg"
  description = "Security Group with HTTP & SSH port open for entire VPC Block (IPv4 CIDR), egress ports are all world open"
  vpc_id      = module.vpc.vpc_id
  # Ingress Rules & CIDR Blocks
  ingress_rules       = ["ssh-tcp", "http-80-tcp"]
  ingress_cidr_blocks = [module.vpc.vpc_cidr_block]
  # Egress Rule - all-all open
  egress_rules = ["all-all"]
  tags         = local.common_tags
}

# AWS EC2 Instance Terraform Module
# EC2 Instances that will be created in VPC Private Subnets
module "ec2_private" {
  depends_on = [module.vpc] # VERY VERY IMPORTANT else userdata webserver provisioning will fail
  source     = "terraform-aws-modules/ec2-instance/aws"
  version = "5.6.0"
  # insert the 10 required variables here
  name          = "${var.environment}-vm"
  ami           = data.aws_ami.amzlinux2.id
  instance_type = var.instance_type
  key_name      = var.instance_keypair
  user_data     = file("${path.module}/app1-install.sh")
  tags          = local.common_tags

  vpc_security_group_ids = [module.private_sg.security_group_id]
  for_each               = toset(["0"])
  subnet_id              = element(module.vpc.private_subnets, tonumber(each.key))
}


