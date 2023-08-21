# enabled must always be true
enabled = true

# This is the domain name of our website
domain_name = "umo.ms"

# This is the name of the S3 bucket
bucket_name = "umo-dot-ms-staging"

# AWS region (us-east-1: Virginia)
region = "us-east-1"

# The intention here is to push site files from github.
# Thusly, we don't need amazon to track this for us.
versioning_enabled = false

# We must explicity set the global bucket policy to allow for public access.
# These 3 things take care of that.  In addition, you must also configure the
# policy documents in main.tf
block_public_policy = false
restrict_public_buckets = false
s3_object_ownership = "BucketOwnerEnforced"

# This will allow terraform to empty the bucket when you run tf destroy
force_destroy = true
