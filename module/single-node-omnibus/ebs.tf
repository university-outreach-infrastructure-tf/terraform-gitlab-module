resource "aws_ebs_volume" "gitlab_data" {
  size              = "${var.gitlab_data_disk_size}"
  kms_key_id        = "${aws_kms_key.gitlab_kms_key.id}"
  encrypted         = true
  type              = "gp2"
  availability_zone = "${data.aws_subnet.selected.availability_zone}"
  tags              = "${merge(map("Name", "${var.name}-_data_disk_size${format("%02d", count.index + 1)}"), map("Role", "${replace(var.name, "-", "_")}_disk_size"), map("Type", "gitlab-data"), map("snapshot_policy", "${var.name}-data Daily Snapshots"))}"
}

resource "aws_volume_attachment" "gitlab_data_attachment" {
  device_name = "${var.gitlab_data_disk_device_name}"
  volume_id   = "${aws_ebs_volume.gitlab_data.id}"
  instance_id = "${aws_instance.gitlab_application.id}"
  force_detach = true
}

resource "aws_dlm_lifecycle_policy" "data" {
  description        = "Gitlab Data Volume DLM lifecycle policy"
  execution_role_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/StackSetDLMRole"
  state              = "ENABLED"

  policy_details {
    resource_types = ["VOLUME"]

    schedule {
      name = "${var.name}-data Daily Snapshots"

      create_rule {
        interval      = "${var.snapshot_interval}"
        interval_unit = "HOURS"
        times         = ["${var.snapshot_start_time}"]
      }

      retain_rule {
        count = "${var.retain_rule}"
      }

      tags_to_add = {
        Snapshot_type = "${var.name}-data-daily-snapshot"
      }

      copy_tags = true
    }

    target_tags = {
      Snapshot = "true"
    }
  }
}

