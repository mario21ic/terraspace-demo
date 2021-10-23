output "bucket_name" {
  description = "Bucket name"
  value       = module.bucket.name
}

output "helper_out" {
  description = "Helper demo"
  value       = local.my_helper_value
}
