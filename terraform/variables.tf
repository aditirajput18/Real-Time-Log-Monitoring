variable "region" {
  default = "us-east-1"
}

variable "project_name" {
  default = "real-time-log-monitor"
}

variable "lambda_s3_bucket" {
  description = "S3 bucket for Lambda deployment package"
  default     = "realtime-log-monitor-lambda-code"
}
