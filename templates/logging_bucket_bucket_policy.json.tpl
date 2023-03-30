{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AllowSourceAccount",
      "Effect": "Allow",
      "Principal": {
          "Service": "s3.amazonaws.com"
      },
      "Action": [
          "s3:PutObject",
          "s3:PutObjectAcl"
      ],
      "Resource": "${s3_bucket_logging_arn}/*",
      "Condition": {
          "StringEquals": {
              "aws:SourceAccount": "${aws_account_id}"
          }
      }
    }
  ]
}