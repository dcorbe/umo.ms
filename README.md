# umo.ms

## Deploying this project

### 1) Change into the appropriate environment (for example, staging)
```$ cd deploy/stage```

### 2) If you haven't already, initialize terraform
```
$ terraform init
```

### 3) Create or update the S3 bucket
```
$ terraform apply
```

### 4) If you're deploying for the first time, you need to seed the bucket
AWS_DEFAULT_REGION needs to match the region config in terraform.tfvars

AWS_BUCKET_NAME should match the name of the S3 bucket 

```
$ export AWS_DEFAULT_REGION=us-east-1
$ export AWS_BUCKET_NAME=umo-dot-ms-staging
$ aws s3 sync ../../src s3://${AWS_BUCKET_NAME}/
```
