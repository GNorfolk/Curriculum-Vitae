resource "aws_s3_bucket" "bucket" {
  bucket = "cv.norfolkgaming.com"
  acl    = "public-read"
  # policy = file("policy.json")
  website {
    index_document = "cv.pdf"
  }
}