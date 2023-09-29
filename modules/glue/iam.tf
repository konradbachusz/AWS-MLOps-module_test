####Glue retraining Job IAM role##########

resource "aws_iam_role" "iam_for_glue_retraining_job_role" {
  name = "${var.model_name}_retraining_job_glue_iam"

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





resource "aws_iam_policy" "retraining_glue_policy" {
  name   = "${var.model_name}_retraining_glue_policy"
  policy = <<EOT
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor1",
            "Effect": "Allow",
            "Action": [
                "rds:ModifyRecommendation",
                "rds:CancelExportTask",
                "rds:DescribeDBEngineVersions",
                "rds:CrossRegionCommunication",
                "rds:DescribeExportTasks",
                "rds:StartExportTask",
                "rds:DescribeEngineDefaultParameters",
                "rds:DeleteDBInstanceAutomatedBackup",
                "rds:DescribeRecommendations",
                "rds:DescribeReservedDBInstancesOfferings",
                "rds:ModifyCertificates",
                "rds:DescribeRecommendationGroups",
                "rds:DescribeOrderableDBInstanceOptions",
                "rds:DescribeEngineDefaultClusterParameters",
                "rds:DescribeSourceRegions",
                "rds:CreateDBProxy",
                "rds:DescribeCertificates",
                "rds:DescribeEventCategories",
                "rds:DescribeAccountAttributes",
                "rds:DescribeEvents"
            ],
            "Resource": "*"
        },

        {
            "Sid": "S3BucketsAccess",
            "Effect": "Allow",
            "Action": [
                "s3:GetObject",
                "s3:PutObject"
            ],
            "Resource": [
                "arn:aws:s3:::${var.topic_bucket}/*", 
                "arn:aws:s3:::${aws_s3_bucket.config_bucket.id}/*"
            ]
        }
    ]
}
EOT
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


####Glue Streaming Job IAM role##########
resource "aws_iam_role" "iam_for_glue_streaming_role" {
  name = "${var.model_name}_streaming_job_glue_iam"

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


resource "aws_iam_policy" "streaming_glue_policy" {
  name   = "${var.model_name}_streaming_glue_policy"
  policy = <<EOT
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "s3:*",
                "kafka:*",
                "ec2:*",
                "glue:*"
            ],
            "Resource": "*"
        }
    ]
}
EOT
  tags   = var.tags
}

resource "aws_iam_role_policy_attachment" "streaming_glue_policy_attachment" {
  role       = aws_iam_role.iam_for_glue_streaming_role.name
  policy_arn = aws_iam_policy.streaming_glue_policy.arn
}

####Quicksight policy##########
/*aws-quicksight-service-role-v0 is used by default in Quicksight. We need to attach an inline policy to allow Quicksight to access the Glue Database (via Athena)*/

resource "aws_iam_policy" "quicksight_athena_policy" {
  name   = "${var.model_name}_quicksight_athena_policy"
  policy = <<EOT
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "s3:*",
                "athena:*"
            ],
            "Resource": "*"
        }
    ]
}
EOT
  tags   = var.tags
}

resource "aws_iam_role_policy_attachment" "quicksight_policy_attachment" {
  role       = "aws-quicksight-service-role-v0"
  policy_arn = aws_iam_policy.quicksight_athena_policy.arn
}
