# AWS S3 bucket for static hosting
resource "aws_s3_bucket" "domain-bucket" {
  bucket = var.domain_name
  acl    = "public-read"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "PublicReadGetObject",
      "Effect": "Allow",
      "Principal": "*",
      "Action": [
          "s3:GetObject"
      ],
      "Resource": [
          "arn:aws:s3:::${var.domain_name}/*"
      ]
    }
  ]
}
EOF

  website {
    index_document = "index.html"
    error_document = "404.html"
  }

  logging {
    target_bucket = aws_s3_bucket.log_bucket.id
    target_prefix = "log/"
  }

  tags = {
    project = "resume"
  }
}

# AWS S3 bucket for www-redirect
resource "aws_s3_bucket" "subdomain-bucket" {
  bucket = "www.${var.domain_name}"

  website {
    redirect_all_requests_to = "http://${var.domain_name}"
  }

  tags = {
    project = "resume"
  }
}

# S3 bucket for website traffic logging
resource "aws_s3_bucket" "log_bucket" {
  bucket = "resume-tf-log-bucket"
  acl    = "log-delivery-write"

  tags = {
    project = "resume"
  }
}
