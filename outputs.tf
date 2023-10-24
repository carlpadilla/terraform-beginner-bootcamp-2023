output "bucket_name" {
  description = "Bucket name for static site"
  value = module.terrahouse_aws.bucket_name
}

output "s3_website_endpoint" {
<<<<<<< HEAD
  description = "S3 Website endpoint URL"
=======
  description = "Bucket name for our static site"
>>>>>>> main
  value = module.terrahouse_aws.website_endpoint
}