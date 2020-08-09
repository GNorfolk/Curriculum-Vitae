data "aws_route53_zone" "cv" {
  name         = "norfolkgaming.com"
  private_zone = true
}