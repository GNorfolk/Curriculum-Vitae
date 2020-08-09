resource "aws_s3_bucket" "bucket" {
  bucket = "cv.norfolkgaming.com"
  acl    = "public-read"
  website {
    index_document = "index.html"
  }
}

resource "aws_s3_bucket_object" "object" {
  bucket  = "cv.norfolkgaming.com"
  key     = "index.html"
  source  = "../../../tex/index.html"
  acl     = "public-read"
  etag    = filemd5("../../../tex/index.html")
}

resource "aws_route53_record" "cv" {
  zone_id = data.aws_route53_zone.cv.zone_id
  name    = "cv.norfolkgaming.com"
  type    = "A"
  alias {
    # zone_id for eu-west-1 s3 comes from here: https://docs.aws.amazon.com/general/latest/gr/s3.html
    name    = "cv.norfolkgaming.com.s3-website-eu-west-1.amazonaws.com"
    zone_id = "Z1BKCTXD74EZPE"
    evaluate_target_health  = false
  }
}
