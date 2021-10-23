output "vpc_id" {
    value = module.vpc.vpc_id
}

output "private_subnet_ids" {
    value = module.vpc.private_subnets
}

output "public_subnet_ids" {
    value = module.vpc.public_subnets
}

output "first_private_subnet_id" {
    value = element(module.vpc.private_subnets, 0)
}

output "first_public_subnet_id" {
    value = element(module.vpc.public_subnets, 0)
}

