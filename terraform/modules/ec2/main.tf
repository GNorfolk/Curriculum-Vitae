resource "aws_instance" "app" {
  ami           = "ami-0d497f1292765adc5"
  instance_type = "t2.micro"
}

resource "aws_security_group" "app" {
  name        = "app"
  vpc_id      = aws_vpc.main.id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}
