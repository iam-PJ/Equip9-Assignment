output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.http_service.public_ip
}

output "s3_bucket_name" {
  description = "Name of the created S3 bucket"
  value       = aws_s3_bucket.bucket.bucket
}
