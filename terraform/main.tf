# ------------------------
# Create S3 bucket for Lambda deployment
# ------------------------
resource "aws_s3_bucket" "lambda_bucket" {
  bucket = var.lambda_s3_bucket
}

# ------------------------
# Create Kinesis Data Stream
# ------------------------
resource "aws_kinesis_stream" "log_stream" {
  name             = "${var.project_name}-stream"
  shard_count      = 1
  retention_period = 24
}

# ------------------------
# Create IAM Role for Lambda
# ------------------------
resource "aws_iam_role" "lambda_role" {
  name = "${var.project_name}-lambda-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Principal = { Service = "lambda.amazonaws.com" }
      Effect = "Allow"
    }]
  })
}

# Attach policies
resource "aws_iam_role_policy_attachment" "lambda_basic_execution" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy_attachment" "kinesis_read" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonKinesisReadOnlyAccess"
}

resource "aws_iam_role_policy_attachment" "opensearch_full" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonOpenSearchServiceFullAccess"
}

# ------------------------
# Create Lambda Function
# ------------------------
resource "aws_lambda_function" "kinesis_to_opensearch" {
  function_name = "${var.project_name}-lambda"
  role          = aws_iam_role.lambda_role.arn
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.9"

  filename         = "${path.module}/../lambda/package.zip"
  source_code_hash = filebase64sha256("${path.module}/../lambda/package.zip")

  environment {
    variables = {
      OPENSEARCH_URL = aws_opensearch_domain.logs.endpoint
      AWS_REGION     = var.region
    }
  }
}

# ------------------------
# Event Source Mapping (Kinesis → Lambda)
# ------------------------
resource "aws_lambda_event_source_mapping" "kinesis_trigger" {
  event_source_arn  = aws_kinesis_stream.log_stream.arn
  function_name     = aws_lambda_function.kinesis_to_opensearch.arn
  starting_position = "LATEST"
}

# ------------------------
# Create OpenSearch Domain
# ------------------------
resource "aws_opensearch_domain" "logs" {
  domain_name = "${var.project_name}-domain"

  cluster_config {
    instance_type = "t3.small.search"
  }

  ebs_options {
    ebs_enabled = true
    volume_size = 10
  }

  access_policies = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = "*"
        Action    = "es:*"
        Resource  = "*"
      }
    ]
  })
}
