output "bucket_name" {
  description = "Bucket name"
  #value       = module.bucket.s3_bucket_id # only when you use terraform registry
  value       = module.bucket.name
}

output "myKey" {
  description = "Demo for test arg cli"
  value       = var.myKey
}
