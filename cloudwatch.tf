module "alarm_label" {
  source  = "cloudposse/label/null"
  version = "0.25.0"

  context     = module.this.context
  label_order = var.label_orders.cloudwatch
  enabled     = var.alarm_create
}

resource "aws_cloudwatch_metric_alarm" "read_bytes_high" {
  alarm_name          = "${module.alarm_label.id}${module.alarm_label.delimiter}read-bytes-high"
  count               = module.alarm_label.enabled && var.alarm_read_bytes_high.create && var.shard_count != null ? 1 : 0
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = var.alarm_read_bytes_high.evaluation_periods
  metric_name         = "GetRecords.Bytes"
  namespace           = "AWS/Kinesis"
  period              = var.alarm_read_bytes_high.period
  statistic           = "Sum"
  tags                = module.this.tags
  threshold           = var.shard_count * var.alarm_read_bytes_high.period * var.alarm_read_bytes_high.threshold_percentage / 100 * 1024 * 1024 * 2
  datapoints_to_alarm = var.alarm_read_bytes_high.datapoints_to_alarm
  treat_missing_data  = "notBreaching"

  alarm_description = jsonencode(merge({
    Severity    = "warning"
    Description = var.alarm_read_bytes_high.alarm_description
  }, module.alarm_label.tags, module.alarm_label.additional_tag_map))

  dimensions = {
    StreamName = aws_kinesis_stream.default.name
  }

  alarm_actions = [var.alarm_topic_arn]
  ok_actions    = [var.alarm_topic_arn]
}

resource "aws_cloudwatch_metric_alarm" "write_bytes_high" {
  alarm_name          = "${module.alarm_label.id}${module.alarm_label.delimiter}write-bytes-high"
  count               = module.alarm_label.enabled && var.alarm_write_bytes_high.create && var.shard_count != null ? 1 : 0
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = var.alarm_write_bytes_high.evaluation_periods
  metric_name         = "IncomingBytes"
  namespace           = "AWS/Kinesis"
  period              = var.alarm_write_bytes_high.period
  statistic           = "Sum"
  tags                = module.this.tags
  threshold           = var.shard_count * var.alarm_write_bytes_high.period * var.alarm_write_bytes_high.threshold_percentage / 100 * 1024 * 1024
  datapoints_to_alarm = var.alarm_write_bytes_high.datapoints_to_alarm
  treat_missing_data  = "notBreaching"

  alarm_description = jsonencode(merge({
    Severity    = "warning"
    Description = var.alarm_write_bytes_high.alarm_description
  }, module.alarm_label.tags, module.alarm_label.additional_tag_map))

  dimensions = {
    StreamName = aws_kinesis_stream.default.name
  }

  alarm_actions = [var.alarm_topic_arn]
  ok_actions    = [var.alarm_topic_arn]
}

resource "aws_cloudwatch_metric_alarm" "write_records_high" {
  alarm_name          = "${module.alarm_label.id}${module.alarm_label.delimiter}write-records-high"
  count               = module.alarm_label.enabled && var.alarm_write_records_high.create && var.shard_count != null ? 1 : 0
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = var.alarm_write_records_high.evaluation_periods
  metric_name         = "IncomingRecords"
  namespace           = "AWS/Kinesis"
  period              = var.alarm_write_records_high.period
  statistic           = "Sum"
  tags                = module.this.tags
  threshold           = var.shard_count * var.alarm_write_records_high.period * var.alarm_write_records_high.threshold_percentage / 100 * 1000
  datapoints_to_alarm = var.alarm_write_records_high.datapoints_to_alarm
  treat_missing_data  = "notBreaching"

  alarm_description = jsonencode(merge({
    Severity    = "warning"
    Description = var.alarm_write_records_high.alarm_description
  }, module.alarm_label.tags, module.alarm_label.additional_tag_map))

  dimensions = {
    StreamName = aws_kinesis_stream.default.name
  }

  alarm_actions = [var.alarm_topic_arn]
  ok_actions    = [var.alarm_topic_arn]
}

resource "aws_cloudwatch_metric_alarm" "iterator_age_high" {
  alarm_name          = "${module.alarm_label.id}${module.alarm_label.delimiter}iterator-age-high"
  count               = module.alarm_label.enabled && var.alarm_iterator_age_high.create ? 1 : 0
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = var.alarm_iterator_age_high.evaluation_periods
  metric_name         = "GetRecords.IteratorAgeMilliseconds"
  namespace           = "AWS/Kinesis"
  period              = var.alarm_iterator_age_high.period
  statistic           = "Maximum"
  tags                = module.this.tags
  threshold           = var.alarm_iterator_age_high.threshold_seconds * 1000
  datapoints_to_alarm = var.alarm_iterator_age_high.datapoints_to_alarm
  treat_missing_data  = "notBreaching"

  alarm_description = jsonencode(merge({
    Severity    = "warning"
    Description = var.alarm_iterator_age_high.alarm_description
  }, module.alarm_label.tags, module.alarm_label.additional_tag_map))

  dimensions = {
    StreamName = aws_kinesis_stream.default.name
  }

  alarm_actions = [var.alarm_topic_arn]
  ok_actions    = [var.alarm_topic_arn]
}

resource "aws_cloudwatch_metric_alarm" "put_records_success_rate" {
  alarm_name = "${module.alarm_label.id}${module.alarm_label.delimiter}put-records-success-rate"
  count      = module.alarm_label.enabled && var.alarm_put_records.create ? 1 : 0

  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = var.alarm_put_records.evaluation_periods
  tags                = module.this.tags
  threshold           = var.alarm_put_records.threshold_percentage
  treat_missing_data  = "notBreaching"
  datapoints_to_alarm = var.alarm_put_records.datapoints_to_alarm
  alarm_description = jsonencode(merge({
    Severity    = "warning"
    Description = var.alarm_put_records.alarm_description
  }, module.alarm_label.tags, module.alarm_label.additional_tag_map))

  metric_query {
    id          = "totalRecords"
    return_data = false

    metric {
      dimensions = {
        "StreamName" = aws_kinesis_stream.default.name
      }
      namespace   = "AWS/Kinesis"
      metric_name = "PutRecords.TotalRecords"
      period      = var.alarm_put_records.period
      stat        = "Sum"
    }
  }

  metric_query {
    id          = "successfulRecods"
    return_data = false

    metric {
      dimensions = {
        "StreamName" = aws_kinesis_stream.default.name
      }
      namespace   = "AWS/Kinesis"
      metric_name = "PutRecords.SuccessfulRecords"
      period      = var.alarm_put_records.period
      stat        = "Sum"
    }
  }

  metric_query {
    expression  = "(successfulRecods / totalRecords) * 100"
    id          = "successRate"
    label       = "successRate"
    return_data = true
  }

  alarm_actions = [var.alarm_topic_arn]
  ok_actions    = [var.alarm_topic_arn]
}

resource "aws_cloudwatch_metric_alarm" "get_records_success_rate" {
  alarm_name          = "${module.alarm_label.id}${module.alarm_label.delimiter}get-records-success-rate"
  count               = module.alarm_label.enabled && var.alarm_get_records.create ? 1 : 0
  comparison_operator = "LessThanOrEqualToThreshold"
  metric_name         = "GetRecords.Success"
  namespace           = "AWS/Kinesis"
  period              = var.alarm_get_records.period
  evaluation_periods  = var.alarm_get_records.evaluation_periods
  datapoints_to_alarm = var.alarm_get_records.datapoints_to_alarm
  statistic           = "Average"
  tags                = module.this.tags
  threshold           = var.alarm_get_records.threshold_percentage / 100
  treat_missing_data  = "notBreaching"

  alarm_description = jsonencode(merge({
    Severity    = "warning"
    Description = var.alarm_get_records.alarm_description
  }, module.alarm_label.tags, module.alarm_label.additional_tag_map))

  dimensions = {
    StreamName = aws_kinesis_stream.default.name
  }

  alarm_actions = [var.alarm_topic_arn]
  ok_actions    = [var.alarm_topic_arn]
}
