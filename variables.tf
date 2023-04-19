variable "alarm_create" {
  type        = bool
  default     = true
  description = "Whether or not to create alarms"
}

# read byes high alarm
variable "alarm_read_bytes_high" {
  type = object({
    create               = optional(bool, true)
    period               = optional(number, 60)
    evaluation_periods   = optional(number, 15)
    alarm_description    = optional(string, "This metric monitors kinesis read bytes utilization")
    datapoints_to_alarm  = optional(number, 10)
    threshold_percentage = optional(number, 80)
  })
  default = {
    create               = true
    period               = 60
    evaluation_periods   = 15
    alarm_description    = "This metric monitors kinesis read bytes utilization"
    datapoints_to_alarm  = 10
    threshold_percentage = 80
  }
  description = "Settings for the read bytes high alarm"
}

# write bytes high alarm
variable "alarm_write_bytes_high" {
  type = object({
    create               = optional(bool, true)
    period               = optional(number, 60)
    evaluation_periods   = optional(number, 15)
    alarm_description    = optional(string, "This metric monitors kinesis write bytes utilization")
    datapoints_to_alarm  = optional(number, 10)
    threshold_percentage = optional(number, 80)
  })
  default = {
    create               = true
    period               = 60
    evaluation_periods   = 15
    alarm_description    = "This metric monitors kinesis write bytes utilization"
    datapoints_to_alarm  = 10
    threshold_percentage = 80
  }
  description = "Settings for the write bytes high alarm"
}

# write records high alarm
variable "alarm_write_records_high" {
  type = object({
    create               = optional(bool, true)
    period               = optional(number, 60)
    evaluation_periods   = optional(number, 15)
    alarm_description    = optional(string, "This metric monitors kinesis write records utilization")
    datapoints_to_alarm  = optional(number, 10)
    threshold_percentage = optional(number, 80)
  })
  default = {
    create               = true
    period               = 60
    evaluation_periods   = 15
    alarm_description    = "This metric monitors kinesis write records utilization"
    datapoints_to_alarm  = 10
    threshold_percentage = 80
  }
  description = "Settings for the write records high alarm"
}

# iterator age alarm
variable "alarm_iterator_age_high" {
  type = object({
    create              = optional(bool, true)
    period              = optional(number, 60)
    evaluation_periods  = optional(number, 15)
    alarm_description   = optional(string, "This metric monitors kinesis iterator age")
    datapoints_to_alarm = optional(number, 10)
    threshold_seconds   = optional(number, 60)
  })
  default = {
    create              = true
    period              = 60
    evaluation_periods  = 15
    alarm_description   = "This metric monitors kinesis iterator age"
    datapoints_to_alarm = 10
    threshold_seconds   = 60
  }
  description = "Settings for the iterator age high alarm"
}

# put records alarm
variable "alarm_put_records" {
  type = object({
    create               = optional(bool, true)
    period               = optional(number, 60)
    evaluation_periods   = optional(number, 15)
    alarm_description    = optional(string, "This metric monitors kinesis put records successful records (percent)")
    datapoints_to_alarm  = optional(number, 10)
    threshold_percentage = optional(number, 99)
  })
  default = {
    create               = true
    period               = 60
    evaluation_periods   = 15
    alarm_description    = "This metric monitors kinesis put records successful records (percent)"
    datapoints_to_alarm  = 10
    threshold_percentage = 99
  }
  description = "Settings for the put records alarm"
}

# get records alarm
variable "alarm_get_records" {
  type = object({
    create               = optional(bool, true)
    period               = optional(number, 60)
    evaluation_periods   = optional(number, 15)
    alarm_description    = optional(string, "This metric monitors kinesis get records successful records (percent)")
    datapoints_to_alarm  = optional(number, 10)
    threshold_percentage = optional(number, 99)
  })
  default = {
    create               = true
    period               = 60
    evaluation_periods   = 15
    alarm_description    = "This metric monitors kinesis get records successful records (percent)"
    datapoints_to_alarm  = 10
    threshold_percentage = 99
  }
  description = "Settings for the get records alarm"
}

variable "shard_count" {
  type        = number
  description = "The number of shards that the stream will use. If the stream_mode is PROVISIONED, this field is required. Amazon has guidelines for specifying the Stream size that should be referenced when creating a Kinesis stream"
  default     = null
}

variable "retention_period" {
  type        = number
  description = "Length of time data records are accessible after they are added to the stream. The maximum value of a stream's retention period is 8760 hours. Minimum value is 24"
  default     = null
}

variable "shard_level_metrics" {
  type        = list(string)
  description = "A list of shard-level CloudWatch metrics which can be enabled for the stream"
  default     = null
}

variable "enforce_consumer_deletion" {
  type        = bool
  description = "A boolean that indicates all registered consumers should be deregistered from the stream so that the stream can be destroyed without error"
  default     = false
}

variable "encryption_type" {
  type        = string
  description = "The encryption type to use. The only acceptable values are NONE or KMS"
  default     = null
}

variable "kms_key_id" {
  type        = string
  description = "The GUID for the customer-managed KMS key to use for encryption. You can also use a Kinesis-owned master key by specifying the alias alias/aws/kinesis"
  default     = null
}

variable "label_orders" {
  type = object({
    cloudwatch = optional(list(string)),
    kinesis    = optional(list(string)),
  })
  default     = {}
  description = "Overrides the `labels_order` for the different labels to modify ID elements appear in the `id`"
}

variable "alarm_topic_arn" {
  type        = string
  default     = null
  description = "ARN of the AWS SNS topic for the CloudWatch alarms"
}
