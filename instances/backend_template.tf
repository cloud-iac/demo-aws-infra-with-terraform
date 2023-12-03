resource "aws_launch_template" "back_template" {
  name                   = "back_template"
  image_id               = "ami-09e70258ddbdf3c90"
  instance_type          = "t2.micro"
  key_name               = "aws-ec2"
  vpc_security_group_ids = var.backend_sg_ids

  user_data = base64encode(
    <<EOT
    #!/bin/bash
    yum update -y
    yum install -y docker docker-registry
    systemctl start docker.service
    systemctl enable docker.service
    EOT 
  )

  tags = {
    Name = "back_template"
  }
}