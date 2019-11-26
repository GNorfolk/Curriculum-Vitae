terraform {
  backend "s3" {
    bucket = "norfolkgaming-tfstate"
    key = "cv-dev.tfstate"
    region = "eu-west-1"
    encrypt = true
  }
}
