resource "aws_iam_user" "s3_user" {
  name = "${var.name}"
  path = "/"
  force_destroy = "false"
}


resource "aws_iam_user_policy_attachment" "s3_allow_policy" {
  user       = "${aws_iam_user.s3_user.name}"
  policy_arn = "${aws_iam_policy.s3_policy.arn}"
}

resource "aws_iam_user_policy_attachment" "deny_put_acl" {
  user       = "${aws_iam_user.s3_user.name}"
  policy_arn = "${aws_iam_policy.deny_put_acl.arn}"
}


resource "aws_iam_access_key" "s3_access_key" {
  user  = "${aws_iam_user.s3_user.name}"
}

resource "aws_iam_policy" "s3_policy" {
  name = "${var.name}_policy"
  path = "/"
  description = "${var.name}_policy"
  policy =  <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:ListBucket",
        "s3:PutObject",
        "s3:GetObject",
        "s3:DeleteObject"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_policy" "deny_put_acl" {
  name = "${var.name}_deny_put_acl_policy"
  path = "/"
  description = "deny_put_acl"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AddPerm",
      "Effect": "Deny",
      "Action": [
        "s3:PutBucketAcl",
        "s3:PutObjectAcl",
        "s3:PutObjectVersionAcl"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_role" "dlm_lifecycle_role" {
  name = "dlm-lifecycle-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "dlm.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "dlm_lifecycle" {
  name = "dlm-lifecycle-policy"
  role = "${aws_iam_role.dlm_lifecycle_role.id}"

  policy = <<EOF
{
   "Version": "2012-10-17",
   "Statement": [
      {
         "Effect": "Allow",
         "Action": [
            "ec2:CreateSnapshot",
            "ec2:DeleteSnapshot",
            "ec2:DescribeVolumes",
            "ec2:DescribeSnapshots"
         ],
         "Resource": "*"
      },
      {
         "Effect": "Allow",
         "Action": [
            "ec2:CreateTags"
         ],
         "Resource": "arn:aws:ec2:*::snapshot/*"
      }
   ]
}
EOF
}