resource "aws_instance" "ec2_instance" {
  ami           = "ami-06650ca7ed78ff6fa" # Replace with an Amazon Linux 2 AMI ID
  instance_type = var.instance_type
  user_data     = base64encode(file("/home/ubuntu/Spartan/userdata.sh"))

  security_groups = [
    aws_security_group.ec2_sg.name
  ]

  tags = {
    Name = "s3-access-ec2"
  }
}
