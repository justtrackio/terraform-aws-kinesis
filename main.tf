module "kinesis_label" {
  source  = "justtrackio/label/null"
  version = "0.26.0"

  context     = module.this.context
  label_order = var.label_orders.kinesis
}

resource "aws_kinesis_stream" "default" {
  name                      = module.kinesis_label.id
  shard_count               = var.shard_count
  retention_period          = var.retention_period
  shard_level_metrics       = var.shard_level_metrics
  tags                      = module.kinesis_label.tags
  enforce_consumer_deletion = var.enforce_consumer_deletion
  encryption_type           = var.encryption_type
  kms_key_id                = var.kms_key_id
  stream_mode_details {
    stream_mode = var.shard_count != null ? "PROVISIONED" : "ON_DEMAND"
  }
}

data "aws_iam_policy_document" "policy" {
  count = length(var.policy_allowed_principals) > 0 && length(var.policy_allowed_actions) > 0 ? 1 : 0

  statement {
    effect  = "Allow"
    actions = var.policy_allowed_actions
    principals {
      identifiers = var.policy_allowed_principals
      type        = "AWS"
    }
    resources = [aws_kinesis_stream.default.arn]
  }
}

resource "aws_kinesis_resource_policy" "policy" {
  count = length(var.policy_allowed_principals) > 0 && length(var.policy_allowed_actions) > 0 ? 1 : 0

  resource_arn = aws_kinesis_stream.default.arn

  policy = data.aws_iam_policy_document.policy[0].json
}
