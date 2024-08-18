module "web_bucket" {
  source                  = "./modules/web-app-s3"
  bucket_name             = local.s3_bucket_name
  elb_service_account_arn = data.aws_elb_service_account.main.arn
  common_tags             = merge(local.common_tags, { Name = "${local.naming_prefix}-bucket" })
}

resource "aws_s3_object" "website_content" {
  for_each = local.website_content
  bucket   = module.web_bucket.bucket.id
  key      = each.value
  source   = "${path.root}${each.value}"
}