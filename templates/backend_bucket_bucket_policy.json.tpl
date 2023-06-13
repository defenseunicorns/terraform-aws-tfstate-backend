{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:ListBucket",
        "s3:GetObject",
        "s3:PutObject"
      ],
      "Effect": "Allow",
      "Resource": [
        "${s3_bucket_arn}/*",
        "${s3_bucket_arn}"
      ],
      "Condition": {
        "Bool": {
          "aws:SecureTransport": "false"
        }
      },
      "Principal": {
        "AWS": ${admin_arns}
      }
    },
    {
      "Action": "s3:*",
      "Effect": "Deny",
      "Resource": [
        "${s3_bucket_arn}/*",
        "${s3_bucket_arn}"
      ],
      "Condition": {
        "ArnNotEquals": {
          "aws:PrincipalArn": ${admin_arns}
        }
      },
      "Principal": "*"
    }
  ]
}
