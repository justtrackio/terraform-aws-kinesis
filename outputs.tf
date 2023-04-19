output "kinesis_stream_arn" {
  value       = aws_kinesis_stream.default.arn
  description = "ARN for the created kinesis stream"
}
