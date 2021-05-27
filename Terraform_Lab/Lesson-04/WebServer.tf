#----------------------------------------------------------
# My Terraform
#
# Build WebServer during Bootstrap
#
# Made by Adhit_Adhya
#----------------------------------------------------------


provider "aws" {
  region = "eu-central-1"
}


resource "aws_instance" "my_webserver" {
  ami                    = "ami-03a71cec707bfc3d7"
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.my_webserver.id]
  user_data = templatefile("user_data.sh.tpl", {
    f_name = "Adhit",
    l_name = "Adhya",
    names  = ["Rikimaru", "Linch", "Sandking", "Luna", "lina", "Lion"]
  })

  tags = {
    Name  = "Web Server Build by Terraform"
    Owner = "Adhit_Adhya"
  }
}


resource "aws_security_group" "my_webserver" {
  name        = "WebServer Security Group"
  description = "My First SecurityGroup"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = "Web Server SecurityGroup"
    Owner = "Adhit_Adhya"
  }
}
