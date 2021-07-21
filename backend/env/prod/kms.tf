resource "aws_kms_key" "resumekmskey" {
  description = "KMS key for resume project"
  
  tags = {
    project = "resume"
  }
}

resource "aws_kms_alias" "resumekmskey" {
  name          = "alias/myResumeKmsKey"
  target_key_id = aws_kms_key.resumekmskey.key_id
}
