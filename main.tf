provider "aws" {
  region = "us-east-2"
}
variable "server_port" {
  description = "The port the server will use for HTTP requests"
  type        = number
  default     = 8080
}
resource "aws_security_group" "terratest_security_group" {
  name = "terratest_security_group"
  ingress {
    from_port   = var.server_port
    to_port     = var.server_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_launch_configuration" "terratest-example-launch-config" {
  image_id        = "ami-0c55b159cbfafe1f0"
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.terratest_security_group.id]
  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p "${var.server_port}" &
              EOF
  lifecycle {
    create_before_destroy = true
  }
}
resource "aws_autoscaling_group" "terratest-example-asg" {
  launch_configuration = aws_launch_configuration.terratest-example-launch-config.id
  availability_zones   = data.aws_availability_zones.all.names
  min_size = 2
  max_size = 10
  tag {
    key                 = "Name"
    value               = "terratest-asg-example"
    propagate_at_launch = true
  }
}
output "url" {
  value = "http://${aws_instance.terratest-example-instance.public_ip}:${var.server_port}"
}