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
            "Resource": "*"
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
                "arn:aws:s3:::*"
            ]
        }, 
        {
          "Sid": "AllowPassRole",
          "Effect": "Allow",
          "Action": "iam:PassRole",
          "Resource": "arn:aws:iam::${var.account_id}:role/${var.model_name}-sagemaker-role"
        }, 
        {
          "Sid": "AllowDescribeLogStreams",
          "Effect": "Allow",
          "Action": "logs:DescribeLogStreams",
          "Resource": "arn:aws:logs:${var.region}:${var.account_id}:log-group:/aws/sagemaker/TrainingJobs:log-stream:*"
        },
        {
          "Sid": "AllowGetLogEvents",
          "Effect": "Allow",
          "Action": "logs:GetLogEvents",
          "Resource": "arn:aws:logs:${var.region}:${var.account_id}:log-group:/aws/sagemaker/TrainingJobs:log-stream:*"
        },
        {
          "Sid": "AllowAccessToKey",
          "Effect": "Allow",
          "Action": [
            "kms:Decrypt", 
            "kms:GenerateDataKey"
          ],
          "Resource": "arn:aws:kms:${var.region}:${var.account_id}:key/*"
        },
        {
          "Sid": "AllowECRPull",
          "Effect": "Allow",
          "Action": [
            "ecr:GetDownloadUrlForLayer",
            "ecr:BatchCheckLayerAvailability"
          ],
          "Resource": "arn:aws:ecr:${var.region}:${var.account_id}:repository/${var.pycaret_ecr_name}"
        },  
        {
          "Sid": "AllowECRPullForIAM",
          "Effect": "Allow",
          "Action": [
            "ecr:GetDownloadUrlForLayer",
            "ecr:BatchCheckLayerAvailability"
          ],
          "Resource": "arn:aws:iam::${var.account_id}:role/${var.model_name}-sagemaker-role"
        },  
        {
            "Sid": "SagemakerCreateModel",
            "Effect": "Allow",
            "Action": "sagemaker:CreateModel",
            "Resource": "*"
        }   
    ]
}
EOF
  tags   = var.tags
}


resource "aws_iam_role_policy_attachment" "sagemaker_policy_attachment" {
  role       = aws_iam_role.sagemaker_role.name
  policy_arn = aws_iam_policy.sagemaker_policy.arn
}
