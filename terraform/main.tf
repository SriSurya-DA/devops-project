provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "devops" {
  ami           = "ami-0f58b397bc5c1f2e8"
  instance_type = "t2.medium"

  security_groups = [aws_security_group.sg.name]
}

resource "aws_security_group" "sg" {
  name = "devops-sg"

  ingress { from_port=22 to_port=22 protocol="tcp" cidr_blocks=["0.0.0.0/0"] }
  ingress { from_port=3000 to_port=3000 protocol="tcp" cidr_blocks=["0.0.0.0/0"] }
  ingress { from_port=9090 to_port=9090 protocol="tcp" cidr_blocks=["0.0.0.0/0"] }
  ingress { from_port=30000 to_port=32767 protocol="tcp" cidr_blocks=["0.0.0.0/0"] }

  egress { from_port=0 to_port=0 protocol="-1" cidr_blocks=["0.0.0.0/0"] }
}
