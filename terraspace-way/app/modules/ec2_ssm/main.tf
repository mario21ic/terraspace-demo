resource "aws_iam_policy" "ssm_policy" {
  name        = "${var.env}_ssm_policy"
  path        = "/"
  description = "Policy for ssm"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
        {
            "Effect": "Allow",
            "Action": [
                "ssm:DescribeAssociation",
                "ssm:GetDeployablePatchSnapshotForInstance",
                "ssm:GetDocument",
                "ssm:DescribeDocument",
                "ssm:GetManifest",
                "ssm:GetParameter",
                "ssm:GetParameters",
                "ssm:ListAssociations",
                "ssm:ListInstanceAssociations",
                "ssm:PutInventory",
                "ssm:PutComplianceItems",
                "ssm:PutConfigurePackageResult",
                "ssm:UpdateAssociationStatus",
                "ssm:UpdateInstanceAssociationStatus",
                "ssm:UpdateInstanceInformation"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "ssmmessages:CreateControlChannel",
                "ssmmessages:CreateDataChannel",
                "ssmmessages:OpenControlChannel",
                "ssmmessages:OpenDataChannel"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "ec2messages:AcknowledgeMessage",
                "ec2messages:DeleteMessage",
                "ec2messages:FailMessage",
                "ec2messages:GetEndpoint",
                "ec2messages:GetMessages",
                "ec2messages:SendReply"
            ],
            "Resource": "*"
        }
    ]
  })
}


resource "aws_iam_role" "ssm_role" {
  name = "${var.env}_ssm_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    env = var.env
  }
}

resource "aws_iam_role_policy_attachment" "ssm-role-policy-attach" {
  role       = aws_iam_role.ssm_role.name
  policy_arn = aws_iam_policy.ssm_policy.arn
}

resource "aws_iam_instance_profile" "ssm_profile" {
  name = "${var.env}_ssm_profile"
  role = aws_iam_role.ssm_role.name
}


data "aws_ami" "amazonv2" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["amazon"]
}


resource "aws_security_group" "proxy_ec2_sg" {
  name        = "${var.env}-proxy-rds-sg"
  description = "Allow inbound traffic"
  vpc_id      = var.vpc_id

  tags = {
    Name = "allow_ssh"
    env = var.env
  }
}

# resource "aws_security_group_rule" "sg_ingress" {
#   type              = "ingress"
#   from_port         = 22
#   to_port           = 22
#   protocol          = "tcp"
#   cidr_blocks       = ["190.238.105.97/32"] // Mario ip
#   //ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
#   security_group_id = aws_security_group.proxy_ec2_sg.id
# }

resource "aws_security_group_rule" "sg_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks      = ["0.0.0.0/0"]
  ipv6_cidr_blocks = ["::/0"]
  security_group_id = aws_security_group.proxy_ec2_sg.id
}

resource "aws_instance" "proxy" {
  ami           = data.aws_ami.amazonv2.id
  #ami           = "${var.ami_id}"
  instance_type = "t3.micro"
  iam_instance_profile = aws_iam_instance_profile.ssm_profile.name

  vpc_security_group_ids  = [aws_security_group.proxy_ec2_sg.id]
  subnet_id               = var.subnet_id

  tags = {
    Name = "${var.env}-proxy-rds"
    env = var.env
  }
}

locals {
  command = "aws ssm start-session --target ${aws_instance.proxy.id} --region ${var.region}"
}

