output "vpc_id" {
  value = module.vpc.vpc_id
}

output "vpc_arn" {
  value = module.vpc.vpc_arn
}

output "vpc_cidr_bloock" {
  value = module.vpc.vpc_cidr_block
}

# enable if you want public subnets
# output "vpc_public_subnets" {
#   value = module.vpc.public_subnets
# }

output "vpc_private_subnets" {
  value = module.vpc.private_subnets
}