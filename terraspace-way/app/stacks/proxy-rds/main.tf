module "ec2_ssm" {
  source = "../../modules/ec2_ssm"

  env = var.env
  region = var.region
  vpc_id = var.vpc_id
  subnet_id = var.subnet_id
}
