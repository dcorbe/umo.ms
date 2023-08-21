provider "aws" {
  region = var.region
}

module "s3_bucket" {
  source  = "cloudposse/s3-bucket/aws"
  version = "3.1.3"

  # See terraform.tfvars for an explanation
  name                    = var.bucket_name
  enabled                 = var.enabled
  versioning_enabled      = var.versioning_enabled
  force_destroy           = var.force_destroy
  block_public_policy     = var.block_public_policy
  restrict_public_buckets = var.restrict_public_buckets
  s3_object_ownership     = var.s3_object_ownership

  # Amazon's recommendation is to use bucket policies
  # over ACLs to control access, so we need to push a
  # policy document to the bucket
  source_policy_documents = [
    jsonencode({
      Statement = [
        {
          Effect    = "Allow",
          Principal = "*",
          Action    = ["s3:GetObject"],
          Resource  = "arn:aws:s3:::${var.bucket_name}/*"
        }
      ]
    })
  ]

  # Website configuration.
  website_configuration = [
    {
      index_document = "index.html"
      error_document = null
      routing_rules = []
      website_domain = var.domain_name
    }
  ]

  # The CORS configuration allows for cross-origin requests.
  # We want to make sure GET is allowed from anywhere.
  # We want to restrict PUT and POST to secure connections
  # from known domains only.
  cors_configuration = [
    {
      allowed_headers = ["*"]
      allowed_methods = ["PUT", "POST"]
      allowed_origins = ["https://${var.domain_name}", "https://www.${var.domain_name}"]
      expose_headers  = ["ETag"]
      max_age_seconds = 3000
    },
    {
      allowed_headers = null
      allowed_methods = ["GET"]
      allowed_origins = ["*"]
      expose_headers  = null
      max_age_seconds = null
    }
  ]
}

