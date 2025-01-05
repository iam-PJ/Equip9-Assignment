variable "region" {
  default = "ap-southeast-1"
}

variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
  default     = "ttmm"
}


variable "instance_type" {
  default = "t2.micro"
}
