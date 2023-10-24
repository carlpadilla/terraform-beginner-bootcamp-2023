output "bucket_name" {
  description = "Bucket name for static site"
  value = module.terrahouse_aws.bucket_name
}

output "s3_website_endpoint" {
  description = "Bucket name for our static site"
  value = module.terrahouse_aws.website_endpoint
}