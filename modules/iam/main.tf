resource "aws_iam_role" "sagemaker_role" {
  name               = "${var.model_name}-sagemaker-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": [
          "sagemaker.amazonaws.com",
          "lambda.amazonaws.com"
        ]
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  tags               = var.tags
}


resource "aws_iam_policy" "sagemaker_policy" {
  name   = "${var.model_name}-sagemaker-policy"
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
	{
            "Effect": "Allow",
            "Action": "sagemaker:*",
            "Resource": "arn:aws:sagemaker:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:*"
        },
        {
            "Effect": "Allow",
            "Action": "logs:CreateLogGroup",
            "Resource": "arn:aws:logs:*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ],
            "Resource": [
                "arn:aws:logs:*"
            ]
        },
	      {
            "Effect": "Allow",
            "Action": [
                "s3:GetObject",
                "s3:PutObject",
                "s3:DeleteObject",
                "s3:ListBucket"
            ],
            "Resource": [
                "arn:aws:s3:::${var.data_s3_bucket}",
                "arn:aws:s3:::${var.data_s3_bucket}/*",
                "arn:aws:s3:::${var.model_name}-model",
                "arn:aws:s3:::${var.model_name}-model/*",
                "arn:aws:s3:::${var.model_name}-config-bucket",
                "arn:aws:s3:::${var.model_name}-config-bucket/*"
            ]
        }, 
        {
          "Sid": "AllowPassRole",
          "Action": "iam:PassRole",
          "Effect": "Allow",
          "Resource": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/*",
          "Condition": {
            "StringEquals": {
              "iam:PassedToService": [
                "sagemaker.amazonaws.com"
              ]
            }
          }
        },
        {
          "Sid": "AllowDescribeLogStreams",
          "Effect": "Allow",
          "Action": "logs:DescribeLogStreams",
          "Resource": "arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:/aws/sagemaker/TrainingJobs:log-stream:*"
        },
        {
          "Sid": "AllowGetLogEvents",
          "Effect": "Allow",
          "Action": "logs:GetLogEvents",
          "Resource": "arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:/aws/sagemaker/TrainingJobs:log-stream:*"
        },
        {
          "Sid": "AllowAccessToKey",
          "Effect": "Allow",
          "Action": [
            "kms:Decrypt", 
            "kms:GenerateDataKey"
          ],
          "Resource": "arn:aws:kms:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:key/*"
        }
    ]
}
EOF
  tags   = var.tags
}


resource "aws_iam_role_policy_attachment" "policy_attachment" {
  role       = aws_iam_role.sagemaker_role.name
  policy_arn = aws_iam_policy.sagemaker_policy.arn
}

resource "aws_iam_role_policy_attachment" "sagemaker_policy_attachment" {
  role       = aws_iam_role.sagemaker_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSageMakerFullAccess"
}
