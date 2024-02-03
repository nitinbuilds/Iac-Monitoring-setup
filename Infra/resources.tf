#provider block
provider "aws" {
  profile = "default"
  region = "us-east-2"
  
}

#EC2 instance, security group
resource "aws_instance" "Nextcloud" {
  ami = "ami-0277155c3f0ab2930"
  instance_type = "t2.medium"
  availability_zone = "us-east-2a"
  vpc_security_group_ids = [aws_security_group.allow_tls.id]

tags = {
    name = "JustoNextcloud"
 }
}
resource "aws_security_group" "allow_tls" {
  name = "nextcloudsg"
ingress {
    description = "allowssh"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
 }
 ingress {
    description = "allownextcloudport"
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
 }
 egress{
    description = "outbound"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
 } 
}
