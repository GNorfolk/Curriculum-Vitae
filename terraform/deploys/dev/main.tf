module "ec2" {
  source = "../../modules/ec2"
  vpc_cidr = "10.0.0.0/16"
}
