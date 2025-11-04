output "kinesis_stream_name" {
  value = aws_kinesis_stream.log_stream.name
}

output "lambda_name" {
  value = aws_lambda_function.kinesis_to_opensearch.function_name
}

output "opensearch_endpoint" {
  value = aws_opensearch_domain.logs.endpoint
}
