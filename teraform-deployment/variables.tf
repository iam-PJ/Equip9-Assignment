variable "aws_region" {
  description = "The AWS region to deploy resources in"
  default     = "ap-southeast-1"
}

variable "ami_id" {
  description = "The AMI ID for the EC2 instance"
  default     = "ami-0358f6ed7ca8a72b6" # Replace with a valid AMI ID
}

variable "instance_type" {
  description = "The instance type for the EC2 instance"
  default     = "t2.micro"
}

variable "key_name" {
  description = "The name of the key pair to use for the EC2 instance"
  default     = "Nobita" # Replace with your key pair name
}

variable "s3_bucket_prefix" {
  description = "Prefix for the S3 bucket name"
  default     = "equip9transport"
}
