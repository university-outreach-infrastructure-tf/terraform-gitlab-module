# -----------------------------------------------------------------------------------------------------------
# S3 Outputs
# -----------------------------------------------------------------------------------------------------------
output "bucket_id" {
  value = "${element(concat(aws_s3_bucket.gitlab_lfs_s3_bucket.*.id, list("")), 0)}"
}

output "bucket_arn" {
  value = "${element(concat(aws_s3_bucket.gitlab_lfs_s3_bucket.*.arn, list("")), 0)}"
}
