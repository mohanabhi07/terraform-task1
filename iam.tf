resource "aws_iam_role" "ec2_role" {
  name = "EC2Role"
  assume_role_policy = jsonencode({
    Version   = "2012-10-17",
    Statement = [{
      Effect    = "Allow",
      Principal = {
        Service = "ec2.amazonaws.com"
      },
      Action    = "sts:AssumeRole"
    }]
  })

  tags = {
    Name = "EC2Role"
  }
}

# Create custom IAM policy allowing read access to specific S3 bucket
resource "aws_iam_policy" "s3_access_policy" {
  name        = "s3_access_policy"
  description = "Policy for accessing specific S3 bucket"
 
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:*",
                "s3-object-lambda:*"
            ],
            "Resource": "*"
        }
    ]
}
EOF
tags = {
  Name="s3_policy"
}
}
 
# Attach IAM policy to IAM role allowing access to specific S3 bucket
resource "aws_iam_policy_attachment" "s3_access_attachment" {
  name       = "s3_access_attachment"
  policy_arn = aws_iam_policy.s3_access_policy.arn
 
  roles = [aws_iam_role.ec2_role.name]
}

resource "aws_iam_instance_profile" "ec2_profile" {
    name="ec2-profile"
    role=aws_iam_role.ec2_role.name
  
}
