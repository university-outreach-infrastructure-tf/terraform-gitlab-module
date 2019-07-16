resource "aws_kms_key" "gitlab_kms_key" {
  description             = "KMS key 1"
  deletion_window_in_days = 10
}

resource "aws_kms_alias" "gitlab_kms_key_alias" {
  name          = "${var.name}-key-alias"
  target_key_id = "${aws_kms_key.gitlab_kms_key.key_id}"
}