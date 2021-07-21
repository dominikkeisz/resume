resource "aws_iam_role" "code_deploy" {
  name = "ServiceRoleForCodeDeploymentsToS3"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "s3.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    project = "resume"
  }
}


resource "aws_iam_role_policy" "code_deploy_policy" {
  name = "StaticSiteCodeDeployPolicy"
  role = aws_iam_role.code_deploy.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow",
        Action   = "s3:ListAllMyBuckets",
        Resource = "arn:aws:s3:::*"
      },
      {
        Effect = "Allow",
        Action = [
          "s3:ListBucket",
          "s3:GetBucketLocation"
        ],
        Resource = "${aws_s3_bucket.domain-bucket.arn}"
      },
      {
        Effect = "Allow",
        Action = [
          "s3:GetObject",
          "s3:GetObjectVersion",
          "s3:GetBucketVersioning",
          "s3:PutObjectAcl",
          "s3:PutObject"
        ],
        Resource = [
          "${aws_s3_bucket.domain-bucket.arn}",
          "${aws_s3_bucket.domain-bucket.arn}/*"
        ]
      }
    ]
  })
}
