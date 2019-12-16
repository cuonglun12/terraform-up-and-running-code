terraform {
  required_version = ">= 0.12, < 0.13"
}

provider "aws" {
  region = "ap-southeast-1"

  # Allow any 2.x version of the AWS provider
  version = "~> 2.0"
}

resource "aws_instance" "example" {
  ami           = "ami-07539a31f72d244e7"
  instance_type = "t2.micro"
  vpc_security_group_ids=["sg-05bf1455a217a53ab"]
  subnet_id="subnet-09981c4e74eb3a574"
  user_data = <<-EOF
    #!/bin/bash
    echo "Hello world " > index.html
    nohup busybox httpd -f -p 8080 &
    EOF
  
  tags={
    Name = "terra example"
  }
}

