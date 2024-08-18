output "bucket" {
  value       = aws_s3_bucket.main
  description = "Created S3 bucket resource"
}

output "ec2_instance_profile" {
  value       = aws_iam_instance_profile.ec2_profile
  description = "EC2 IAM instance profile"
}