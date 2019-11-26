data "aws_vpc" "main" {
  tags = {
    Name = "main"
  }
}

data "aws_subnet" "app_az_a" {
  tags = {
    Name = "app_az_a"
  }
}
