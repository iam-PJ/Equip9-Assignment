resource "aws_s3_bucket" "my_bucket" {
  bucket = var.bucket_name  # This comes from variables.tf
  acl    = "private"        # ACL is private, no public access by default

  tags = {
    Name        = var.bucket_name
    Environment = "Dev"
  }
}

# Bucket Policy to allow public read access to all objects in the bucket
resource "aws_s3_bucket_object" "my_bucket_policy" {
  bucket = aws_s3_bucket.my_bucket.bucket
  key    = "bucket-policy.json"
  acl    = "private"
  content = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "arn:aws:s3:::${aws_s3_bucket.my_bucket.bucket}/*"
      }
    ]
  })
}

# Attach the Bucket Policy to the S3 bucket
resource "aws_s3_bucket_policy" "my_bucket_policy" {
  bucket = aws_s3_bucket.my_bucket.bucket
  policy = aws_s3_bucket_object.my_bucket_policy.content
}
