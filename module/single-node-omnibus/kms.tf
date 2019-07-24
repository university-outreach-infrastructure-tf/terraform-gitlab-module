resource "aws_kms_key" "gitlab_kms_key" {
  description             = "Gitlab KMS key"
  deletion_window_in_days = 10
  tags                    = module.gitlab_label.tags
  enable_key_rotation     = var.enable_key_rotation
}

resource "aws_kms_alias" "gitlab_kms_key_alias" {
  name          = coalesce(var.alias, format("alias/%v", module.gitlab_label.id))
  target_key_id = aws_kms_key.gitlab_kms_key.key_id
}