{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": ${admin_arns}
  },
    "Action": [
      "s3:ListBucket",
      "s3:GetObject",
      "s3:PutObject"
    ],
    "Resource": [
      "${s3_bucket_arn}/*",
      "${s3_bucket_arn}"
    ],
    "Condition": {
      "Bool": {
        "aws:SecureTransport": "false"
      }
    }
    },
    {
      "NotPrincipal": {
        "AWS": ${admin_arns}
  },
    "Action": [
      "s3:*"
    ],
    "Resource": [
      "${s3_bucket_arn}/*",
      "${s3_bucket_arn}"
    ],
    "Effect": "Deny"
    }
  ]
}
