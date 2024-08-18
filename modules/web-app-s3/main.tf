resource "aws_s3_bucket" "main" {
  bucket        = var.bucket_name
  force_destroy = true

  tags = var.common_tags
}

resource "aws_s3_bucket_policy" "allow_access_from_lb" {
  bucket = aws_s3_bucket.main.id
  policy = data.aws_iam_policy_document.allow_access_from_lb.json
}

data "aws_iam_policy_document" "allow_access_from_lb" {
  statement {
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = [var.elb_service_account_arn]
    }

    actions = ["s3:PutObject"]

    resources = [
      aws_s3_bucket.main.arn,
      "${aws_s3_bucket.main.arn}/*",
    ]
  }
}

# aws_iam_role
resource "aws_iam_role" "ec2_bucket" {
  name = "${var.bucket_name}-ec2_bucket"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = var.common_tags
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "${var.bucket_name}-ec2_profile"
  role = aws_iam_role.ec2_bucket.name

  tags = var.common_tags
}

resource "aws_iam_role_policy" "allow_s3_all" {
  name = "${var.bucket_name}-allow_s3_all"
  role = aws_iam_role.ec2_bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:*"
        ]
        Effect = "Allow"
        Resource = [
          "${aws_s3_bucket.main.arn}",
          "${aws_s3_bucket.main.arn}/*",
        ]
      },
    ]
  })
}