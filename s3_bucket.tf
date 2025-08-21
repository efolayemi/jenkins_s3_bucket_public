provider "aws" {
    region = "eu-west-2"
}

#creation of the bucket
resource "aws_s3_bucket" "public_bucket" {
    bucket = "fola-jenkins-s3-bucket"
}

#object owner
resource "aws_s3_bucket_ownership_controls" "ownership" {
  bucket = aws_s3_bucket.public_bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

#Public Accessibility to bucket enabled
resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket                  = aws_s3_bucket.public_bucket.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "bucket_acl" {
  depends_on = [
    aws_s3_bucket_ownership_controls.ownership,
    aws_s3_bucket_public_access_block.public_access,
  ]
  bucket = aws_s3_bucket.public_bucket.id
  acl    = "public-read"
}
