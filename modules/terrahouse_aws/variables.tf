variable "user_uuid" {
  description = "User UUID"
  type        = string

  validation {
    condition     = can(regex("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$", var.user_uuid))
    error_message = "Invalid user UUID format. It should be in the format of a UUID, e.g., '123e4567-e89b-12d3-a456-426655440000'."
  }
}

variable "bucket_name" {
  description = "Name of the AWS S3 bucket"
  type        = string

  validation {
    condition     = can(regex("^[-a-z0-9]+$", var.bucket_name))
    error_message = "Invalid bucket name. Bucket names must consist of only lowercase letters, numbers, and hyphens (-)."
  }
}
