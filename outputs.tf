output "s3_bucket_arn" {
  value = aws_s3_bucket.my_bucket.arn
}

output "s3_bucket_name" {
  value = aws_s3_bucket.my_bucket.bucket
}

output "ec2_public_ip" {
  value = aws_instance.ec2_instance.public_ip
}
