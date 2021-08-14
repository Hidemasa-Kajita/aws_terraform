// policy, cors の設定が必要
resource "aws_s3_bucket" "bucket" {
  bucket = "tfbucketmcdlknvejk8u"
  acl    = "private"

  tags = {
    Name      = "bucket"
    Env       = "${var.env}"
    CreatedBy = "${var.created_by}"
  }
}