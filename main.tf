provider "aws" {
  region = "us-east-2"
}
resource "aws_security_group" "terratest_security_group" {
  name = "terratest_security_group"
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_instance" "terratest-example-instance" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.terratest_security_group.id]

  user_data = <<-EOF
    #!/bin/bash
    echo "Hello, World" > index.html
    nohup busybox httpd -f -p 8080 &
    EOF
  tags = {
    Name = "terratest-example"
  }
}
output "url" {
  value = "http://${aws_instance.terratest-example-instance.public_ip}:8080"
}