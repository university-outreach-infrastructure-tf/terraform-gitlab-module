# -----------------------------------------------------------------------------------------------------------
# S3 Outputs
# -----------------------------------------------------------------------------------------------------------
output "gitlab_lfs_s3_bucket_id" {
  value = "${aws_s3_bucket.gitlab_s3_bucket.*.id}"
}

output "gitlab_lfs_s3_bucket_Arn" {
  value = "${aws_s3_bucket.gitlab_s3_bucket.*.arn}"
}
