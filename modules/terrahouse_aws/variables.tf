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

variable "index_html_filepath" {
  description = "The file path for the index.html"
  type        = string

  validation {
    condition     = fileexists(var.index_html_filepath)
    error_message = "The specified index_html_filepath does not exist."
  }
}

variable "error_html_filepath" {
  description = "The file path for the error.html"
  type        = string

  validation {
    condition     = fileexists(var.error_html_filepath)
    error_message = "The specified index_html_filepath does not exist."
  }
}

variable "content_version" {
  description = "The version of the content. Must be a positive integer starting at 1."
  type        = number

  validation {
    condition     = var.content_version >= 1 && floor(var.content_version) == var.content_version
    error_message = "The content_version must be a positive integer starting at 1."
  }
}

variable "assets_path" {
  description = "Path to assets folder"
  type = string
  
}