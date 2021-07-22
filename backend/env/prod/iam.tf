resource "aws_iam_user" "resume_deployer" {
  name = "ResumeDeployer"
}

resource "aws_iam_user_policy" "code_deploy_policy" {
  name = "StaticSiteCodeDeployPolicy"
  user = aws_iam_user.resume_deployer.name

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
      },
      {
        Effect = "Allow",
        Action = [
          "cloudfront:ListDistributions",
          "cloudfront:CreateInvalidation"
        ],
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_access_key" "resume_deployer" {
  user = aws_iam_user.resume_deployer.name
}
