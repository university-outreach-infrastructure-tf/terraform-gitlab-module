resource "aws_ebs_volume" "gitlab_data" {
  size              = var.gitlab_data_disk_size
  kms_key_id        = aws_kms_key.gitlab_kms_key.arn
  encrypted         = true
  type              = "gp2"
  availability_zone = data.aws_subnet.private_selected.availability_zone
  tags  = {
      "Name" = format("%s-gitlab-data-disk",module.gitlab_label.name),
      "Type" = "gitlab-data",
      "snapshot_policy" = format("%s-data daily snapshots", module.gitlab_label.name),
      "Snapshot"=  "true"
  }
}

resource "aws_volume_attachment" "gitlab_data_attachment" {
  device_name = var.gitlab_data_disk_device_name
  volume_id   = aws_ebs_volume.gitlab_data.id
  instance_id = aws_instance.gitlab_application.id
  force_detach = true
}

resource "aws_dlm_lifecycle_policy" "gitlab_data_snapshot_policy" {
  description        = "Gitlab Data Volume DLM lifecycle policy"
  execution_role_arn = aws_iam_role.dlm_lifecycle_role.arn
  state              = "ENABLED"

  policy_details {
    resource_types = ["VOLUME"]

    schedule {
      name = format("%s-data daily snapshots", module.gitlab_label.name)

      create_rule {
        interval      = var.snapshot_interval
        interval_unit = "HOURS"
        times         = flatten(var.snapshot_start_time)
      }

      retain_rule {
        count = var.retain_rule
      }

      tags_to_add = {
        Snapshot_type = format("%s-data daily snapshots", module.gitlab_label.name)
      }

      copy_tags = true
    }

    target_tags = {
      Snapshot = "true"
    }
  }
}