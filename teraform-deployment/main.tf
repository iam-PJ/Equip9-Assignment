provider "aws" {
  region = var.aws_region
}

resource "aws_instance" "http_service" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  security_groups = [aws_security_group.http_sg.name]

  tags = {
    Name = "HTTPServiceInstance"
  }

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y python3
              pip3 install flask boto3
              mkdir -p /home/ec2-user/aws_http_service
              echo "Running Flask app..."
              python3 /home/ec2-user/aws_http_service/newcode.py > /var/log/newcode.log 2>&1 &
              EOF
}

resource "aws_security_group" "http_sg" {
  name        = "http_sg"
  description = "Allow HTTP and SSH traffic"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_s3_bucket" "bucket" {
  bucket = "${var.s3_bucket_prefix}-${random_string.unique_id.result}"
}

resource "random_string" "unique_id" {
  length  = 6
  special = false
}
