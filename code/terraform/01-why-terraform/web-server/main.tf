terraform {
  required_version = ">= 0.12, < 0.13"
}

provider "aws" {
  region = "ap-southeast-1"

  # Allow any 2.x version of the AWS provider
  version = "~> 2.0"
}

resource "aws_instance" "example" {
  instance_type     = "t2.micro"
  availability_zone = "ap-southeast-1a"
  ami               = "ami-07539a31f72d244e7"
  vpc_security_group_ids = [aws_security_group.instance.id]
  subnet_id="subnet-09981c4e74eb3a574"
  user_data = <<-EOF
              #!/bin/bash
              sudo service apache2 start
              EOF
  tags = {
    Name = "terra lab"
  }
}

resource "aws_security_group" "instance" {
  name = "terraform-example-"
  vpc_id="vpc-084640cab619447f7"  
  ingress{
    from_port = var.server_port
    to_port = var.server_port
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

