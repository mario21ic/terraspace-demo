output "ssm_profile_name" {
  value = aws_iam_instance_profile.ssm_profile.name
}

output "ssm_command" {
  value = local.command
}

