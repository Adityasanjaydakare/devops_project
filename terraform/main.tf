provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "app_server" {
  ami           = "ami-0ff91eb5c6fe7cc86"   # Ubuntu 22.04 (Mumbai)
  instance_type = "t3.micro"
  key_name      = "key"   # change to your key pair name

  tags = {
    Name = "DevSecOps-App-Server"
  }
}

output "server_ip" {
  value = aws_instance.app_server.public_ip
}
