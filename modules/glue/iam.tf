####Glue retraining Job IAM role##########
locals {
  s3_buckets   = [var.config_s3_bucket, var.data_s3_bucket]
  kms_key_arns = compact([var.config_bucket_key_arn, var.data_bucket_key_arn])
}

resource "aws_iam_role" "iam_for_glue_retraining_job_role" {
  name = "${var.model_name}-retraining-job-glue-iam"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": [
          "glue.amazonaws.com"
        ]
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  tags               = var.tags
}

data "aws_iam_policy_document" "retraining_glue" {
  statement {
    sid = "S3Access"
    actions = [
      "s3:ListBucket"
    ]
    resources = [for bucket in local.s3_buckets : "arn:aws:s3:::${bucket}"]
  }

  statement {
    sid = "S3ObjectAccess"
    actions = [
      "s3:GetObject",
      "s3:PutObject"
    ]

    resources = [for bucket in local.s3_buckets : "arn:aws:s3:::${bucket}/*"]
  }

  statement {
    sid = "KMSAccess"
    actions = [
      "kms:Decrypt",
      "kms:GenerateDataKey"
    ]

    resources = local.kms_key_arns
  }
}

resource "aws_iam_policy" "retraining_glue_policy" {
  name   = "${var.model_name}-retraining-glue-policy"
  policy = data.aws_iam_policy_document.retraining_glue.json
  tags   = var.tags
}

resource "aws_iam_role_policy_attachment" "AWSGlueServiceRole" {
  role       = aws_iam_role.iam_for_glue_retraining_job_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole"
}

resource "aws_iam_role_policy_attachment" "retraining_glue_policy_attachment" {
  role       = aws_iam_role.iam_for_glue_retraining_job_role.name
  policy_arn = aws_iam_policy.retraining_glue_policy.arn
}

resource "aws_iam_role_policy_attachment" "AWSGlueConsoleFullAccess" {
  role       = aws_iam_role.iam_for_glue_retraining_job_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSGlueConsoleFullAccess"
}
