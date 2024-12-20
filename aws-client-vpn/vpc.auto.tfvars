# VPC Variables
vpc_name = "vpnvpc"
vpc_cidr_block = "10.0.0.0/16"
vpc_availability_zones = ["us-east-1a", "us-east-1b"]
vpc_public_subnets = ["10.0.101.0/24"]
vpc_private_subnets = ["10.0.1.0/24"]
vpc_database_subnets= ["10.0.151.0/24"]
vpc_create_database_subnet_group = true 
vpc_create_database_subnet_route_table = true   
vpc_enable_nat_gateway = true  
vpc_single_nat_gateway = true
domain_name = "*.domain.name" #change this with your domain name
