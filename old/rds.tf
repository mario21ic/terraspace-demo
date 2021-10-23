# RDS
module "rds_sg" {
  source = "terraform-aws-modules/security-group/aws"
  version = "4.3.0"
  #source = "../../../../../vendor/modules/sg"

  name        = "rds-sg"
  description = "Security group for Postgres"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks      = ["10.10.0.0/16"]
  ingress_rules            = ["tcp-5432"]
  ingress_with_cidr_blocks = [
    {
      from_port   = 5432
      to_port     = 5432
      protocol    = "tcp"
      description = "Postgresql port"
      cidr_blocks = "10.10.0.0/16"
    },
    {
      rule        = "postgresql-tcp"
      cidr_blocks = "0.0.0.0/0"
    },
  ]
}

module "rds_instance" {
  source  = "terraform-aws-modules/rds/aws"
  version = "~> 3.0"
  #source = "../../../../../vendor/modules/rds"

  identifier = "my-rds"

  engine            = "postgres"
  engine_version    = "12.7"
  instance_class    = "db.t2.micro"
  allocated_storage = 20

  name     = "db_demo"
  username = "my_us3r"
  password = "CL4ve1112233"
  port     = "5432"

  iam_database_authentication_enabled = false

  vpc_security_group_ids = [module.rds_sg.security_group_id]

  maintenance_window = "Mon:00:00-Mon:03:00"
  backup_window      = "03:00-06:00"

  # Enhanced Monitoring - see example for details on how to create the role
  # by yourself, in case you don't want to create it automatically
  monitoring_interval = "30"
  monitoring_role_name = "MyRDSMonitoringRole"
  create_monitoring_role = true

  tags = {
    Owner       = "user"
    Environment = "dev"
  }

  # DB subnet group
  subnet_ids = module.vpc.private_subnets

  family = "postgres12"
  major_engine_version = "12"

  deletion_protection = false
}

