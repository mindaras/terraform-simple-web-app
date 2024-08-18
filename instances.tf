data "aws_ssm_parameter" "amzn2_linux" {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

resource "aws_instance" "nginx_instances" {
  count                  = var.instance_count
  ami                    = nonsensitive(data.aws_ssm_parameter.amzn2_linux.value)
  instance_type          = var.instance_type
  subnet_id              = module.app.public_subnets[(count.index % var.vpc_public_subnet_count)]
  vpc_security_group_ids = [aws_security_group.nginx_sg.id]
  iam_instance_profile   = module.web_bucket.ec2_instance_profile.name
  depends_on             = [module.web_bucket]

  tags = merge(local.common_tags, { Name = "${local.naming_prefix}-nginx_instance-${count.index}" })

  user_data = templatefile("${path.module}/templates/startup_script.tpl", {
    s3_bucket_name = module.web_bucket.bucket.id
  })
}
