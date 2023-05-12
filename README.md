# terraform-aws-kinesis
Terraform module which creates a kinesis stream including alarms

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.67 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.67 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_alarm_label"></a> [alarm\_label](#module\_alarm\_label) | cloudposse/label/null | 0.25.0 |
| <a name="module_kinesis_label"></a> [kinesis\_label](#module\_kinesis\_label) | cloudposse/label/null | 0.25.0 |
| <a name="module_this"></a> [this](#module\_this) | justtrackio/label/null | 0.26.0 |

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_metric_alarm.get_records_success_rate](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.iterator_age_high](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.put_records_success_rate](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.read_bytes_high](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.write_bytes_high](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.write_records_high](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_kinesis_stream.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kinesis_stream) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_tag_map"></a> [additional\_tag\_map](#input\_additional\_tag\_map) | Additional key-value pairs to add to each map in `tags_as_list_of_maps`. Not added to `tags` or `id`.<br>This is for some rare cases where resources want additional configuration of tags<br>and therefore take a list of maps with tag key, value, and additional configuration. | `map(string)` | `{}` | no |
| <a name="input_alarm_create"></a> [alarm\_create](#input\_alarm\_create) | Whether or not to create alarms | `bool` | `true` | no |
| <a name="input_alarm_get_records"></a> [alarm\_get\_records](#input\_alarm\_get\_records) | Settings for the get records alarm | <pre>object({<br>    create               = optional(bool, true)<br>    period               = optional(number, 60)<br>    evaluation_periods   = optional(number, 15)<br>    alarm_description    = optional(string, "This metric monitors kinesis get records successful records (percent)")<br>    datapoints_to_alarm  = optional(number, 10)<br>    threshold_percentage = optional(number, 99)<br>  })</pre> | <pre>{<br>  "alarm_description": "This metric monitors kinesis get records successful records (percent)",<br>  "create": true,<br>  "datapoints_to_alarm": 10,<br>  "evaluation_periods": 15,<br>  "period": 60,<br>  "threshold_percentage": 99<br>}</pre> | no |
| <a name="input_alarm_iterator_age_high"></a> [alarm\_iterator\_age\_high](#input\_alarm\_iterator\_age\_high) | Settings for the iterator age high alarm | <pre>object({<br>    create              = optional(bool, true)<br>    period              = optional(number, 60)<br>    evaluation_periods  = optional(number, 15)<br>    alarm_description   = optional(string, "This metric monitors kinesis iterator age")<br>    datapoints_to_alarm = optional(number, 10)<br>    threshold_seconds   = optional(number, 60)<br>  })</pre> | <pre>{<br>  "alarm_description": "This metric monitors kinesis iterator age",<br>  "create": true,<br>  "datapoints_to_alarm": 10,<br>  "evaluation_periods": 15,<br>  "period": 60,<br>  "threshold_seconds": 60<br>}</pre> | no |
| <a name="input_alarm_put_records"></a> [alarm\_put\_records](#input\_alarm\_put\_records) | Settings for the put records alarm | <pre>object({<br>    create               = optional(bool, true)<br>    period               = optional(number, 60)<br>    evaluation_periods   = optional(number, 15)<br>    alarm_description    = optional(string, "This metric monitors kinesis put records successful records (percent)")<br>    datapoints_to_alarm  = optional(number, 10)<br>    threshold_percentage = optional(number, 99)<br>  })</pre> | <pre>{<br>  "alarm_description": "This metric monitors kinesis put records successful records (percent)",<br>  "create": true,<br>  "datapoints_to_alarm": 10,<br>  "evaluation_periods": 15,<br>  "period": 60,<br>  "threshold_percentage": 99<br>}</pre> | no |
| <a name="input_alarm_read_bytes_high"></a> [alarm\_read\_bytes\_high](#input\_alarm\_read\_bytes\_high) | Settings for the read bytes high alarm | <pre>object({<br>    create               = optional(bool, true)<br>    period               = optional(number, 60)<br>    evaluation_periods   = optional(number, 15)<br>    alarm_description    = optional(string, "This metric monitors kinesis read bytes utilization")<br>    datapoints_to_alarm  = optional(number, 10)<br>    threshold_percentage = optional(number, 80)<br>  })</pre> | <pre>{<br>  "alarm_description": "This metric monitors kinesis read bytes utilization",<br>  "create": true,<br>  "datapoints_to_alarm": 10,<br>  "evaluation_periods": 15,<br>  "period": 60,<br>  "threshold_percentage": 80<br>}</pre> | no |
| <a name="input_alarm_topic_arn"></a> [alarm\_topic\_arn](#input\_alarm\_topic\_arn) | ARN of the AWS SNS topic for the CloudWatch alarms | `string` | `null` | no |
| <a name="input_alarm_write_bytes_high"></a> [alarm\_write\_bytes\_high](#input\_alarm\_write\_bytes\_high) | Settings for the write bytes high alarm | <pre>object({<br>    create               = optional(bool, true)<br>    period               = optional(number, 60)<br>    evaluation_periods   = optional(number, 15)<br>    alarm_description    = optional(string, "This metric monitors kinesis write bytes utilization")<br>    datapoints_to_alarm  = optional(number, 10)<br>    threshold_percentage = optional(number, 80)<br>  })</pre> | <pre>{<br>  "alarm_description": "This metric monitors kinesis write bytes utilization",<br>  "create": true,<br>  "datapoints_to_alarm": 10,<br>  "evaluation_periods": 15,<br>  "period": 60,<br>  "threshold_percentage": 80<br>}</pre> | no |
| <a name="input_alarm_write_records_high"></a> [alarm\_write\_records\_high](#input\_alarm\_write\_records\_high) | Settings for the write records high alarm | <pre>object({<br>    create               = optional(bool, true)<br>    period               = optional(number, 60)<br>    evaluation_periods   = optional(number, 15)<br>    alarm_description    = optional(string, "This metric monitors kinesis write records utilization")<br>    datapoints_to_alarm  = optional(number, 10)<br>    threshold_percentage = optional(number, 80)<br>  })</pre> | <pre>{<br>  "alarm_description": "This metric monitors kinesis write records utilization",<br>  "create": true,<br>  "datapoints_to_alarm": 10,<br>  "evaluation_periods": 15,<br>  "period": 60,<br>  "threshold_percentage": 80<br>}</pre> | no |
| <a name="input_attributes"></a> [attributes](#input\_attributes) | ID element. Additional attributes (e.g. `workers` or `cluster`) to add to `id`,<br>in the order they appear in the list. New attributes are appended to the<br>end of the list. The elements of the list are joined by the `delimiter`<br>and treated as a single ID element. | `list(string)` | `[]` | no |
| <a name="input_aws_account_id"></a> [aws\_account\_id](#input\_aws\_account\_id) | AWS account id | `string` | `null` | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region | `string` | `null` | no |
| <a name="input_context"></a> [context](#input\_context) | Single object for setting entire context at once.<br>See description of individual variables for details.<br>Leave string and numeric variables as `null` to use default value.<br>Individual variable settings (non-null) override settings in context object,<br>except for attributes, tags, and additional\_tag\_map, which are merged. | `any` | <pre>{<br>  "additional_tag_map": {},<br>  "attributes": [],<br>  "delimiter": null,<br>  "descriptor_formats": {},<br>  "enabled": true,<br>  "environment": null,<br>  "id_length_limit": null,<br>  "label_key_case": null,<br>  "label_order": [],<br>  "label_value_case": null,<br>  "labels_as_tags": [<br>    "unset"<br>  ],<br>  "name": null,<br>  "namespace": null,<br>  "regex_replace_chars": null,<br>  "stage": null,<br>  "tags": {},<br>  "tenant": null<br>}</pre> | no |
| <a name="input_delimiter"></a> [delimiter](#input\_delimiter) | Delimiter to be used between ID elements.<br>Defaults to `-` (hyphen). Set to `""` to use no delimiter at all. | `string` | `null` | no |
| <a name="input_descriptor_formats"></a> [descriptor\_formats](#input\_descriptor\_formats) | Describe additional descriptors to be output in the `descriptors` output map.<br>Map of maps. Keys are names of descriptors. Values are maps of the form<br>`{<br>   format = string<br>   labels = list(string)<br>}`<br>(Type is `any` so the map values can later be enhanced to provide additional options.)<br>`format` is a Terraform format string to be passed to the `format()` function.<br>`labels` is a list of labels, in order, to pass to `format()` function.<br>Label values will be normalized before being passed to `format()` so they will be<br>identical to how they appear in `id`.<br>Default is `{}` (`descriptors` output will be empty). | `any` | `{}` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Set to false to prevent the module from creating any resources | `bool` | `null` | no |
| <a name="input_encryption_type"></a> [encryption\_type](#input\_encryption\_type) | The encryption type to use. The only acceptable values are NONE or KMS | `string` | `null` | no |
| <a name="input_enforce_consumer_deletion"></a> [enforce\_consumer\_deletion](#input\_enforce\_consumer\_deletion) | A boolean that indicates all registered consumers should be deregistered from the stream so that the stream can be destroyed without error | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | ID element. Usually used for region e.g. 'uw2', 'us-west-2', OR role 'prod', 'staging', 'dev', 'UAT' | `string` | `null` | no |
| <a name="input_id_length_limit"></a> [id\_length\_limit](#input\_id\_length\_limit) | Limit `id` to this many characters (minimum 6).<br>Set to `0` for unlimited length.<br>Set to `null` for keep the existing setting, which defaults to `0`.<br>Does not affect `id_full`. | `number` | `null` | no |
| <a name="input_kms_key_id"></a> [kms\_key\_id](#input\_kms\_key\_id) | The GUID for the customer-managed KMS key to use for encryption. You can also use a Kinesis-owned master key by specifying the alias alias/aws/kinesis | `string` | `null` | no |
| <a name="input_label_key_case"></a> [label\_key\_case](#input\_label\_key\_case) | Controls the letter case of the `tags` keys (label names) for tags generated by this module.<br>Does not affect keys of tags passed in via the `tags` input.<br>Possible values: `lower`, `title`, `upper`.<br>Default value: `title`. | `string` | `null` | no |
| <a name="input_label_order"></a> [label\_order](#input\_label\_order) | The order in which the labels (ID elements) appear in the `id`.<br>Defaults to ["namespace", "environment", "stage", "name", "attributes"].<br>You can omit any of the 6 labels ("tenant" is the 6th), but at least one must be present. | `list(string)` | `null` | no |
| <a name="input_label_orders"></a> [label\_orders](#input\_label\_orders) | Overrides the `labels_order` for the different labels to modify ID elements appear in the `id` | <pre>object({<br>    cloudwatch = optional(list(string)),<br>    kinesis    = optional(list(string)),<br>  })</pre> | `{}` | no |
| <a name="input_label_value_case"></a> [label\_value\_case](#input\_label\_value\_case) | Controls the letter case of ID elements (labels) as included in `id`,<br>set as tag values, and output by this module individually.<br>Does not affect values of tags passed in via the `tags` input.<br>Possible values: `lower`, `title`, `upper` and `none` (no transformation).<br>Set this to `title` and set `delimiter` to `""` to yield Pascal Case IDs.<br>Default value: `lower`. | `string` | `null` | no |
| <a name="input_labels_as_tags"></a> [labels\_as\_tags](#input\_labels\_as\_tags) | Set of labels (ID elements) to include as tags in the `tags` output.<br>Default is to include all labels.<br>Tags with empty values will not be included in the `tags` output.<br>Set to `[]` to suppress all generated tags.<br>**Notes:**<br>  The value of the `name` tag, if included, will be the `id`, not the `name`.<br>  Unlike other `null-label` inputs, the initial setting of `labels_as_tags` cannot be<br>  changed in later chained modules. Attempts to change it will be silently ignored. | `set(string)` | <pre>[<br>  "default"<br>]</pre> | no |
| <a name="input_name"></a> [name](#input\_name) | ID element. Usually the component or solution name, e.g. 'app' or 'jenkins'.<br>This is the only ID element not also included as a `tag`.<br>The "name" tag is set to the full `id` string. There is no tag with the value of the `name` input. | `string` | `null` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | ID element. Usually an abbreviation of your organization name, e.g. 'eg' or 'cp', to help ensure generated IDs are globally unique | `string` | `null` | no |
| <a name="input_organizational_unit"></a> [organizational\_unit](#input\_organizational\_unit) | Usually used to indicate the AWS organizational unit, e.g. 'prod', 'sdlc' | `string` | `null` | no |
| <a name="input_regex_replace_chars"></a> [regex\_replace\_chars](#input\_regex\_replace\_chars) | Terraform regular expression (regex) string.<br>Characters matching the regex will be removed from the ID elements.<br>If not set, `"/[^a-zA-Z0-9-]/"` is used to remove all characters other than hyphens, letters and digits. | `string` | `null` | no |
| <a name="input_retention_period"></a> [retention\_period](#input\_retention\_period) | Length of time data records are accessible after they are added to the stream. The maximum value of a stream's retention period is 8760 hours. Minimum value is 24 | `number` | `null` | no |
| <a name="input_shard_count"></a> [shard\_count](#input\_shard\_count) | The number of shards that the stream will use. If the stream\_mode is PROVISIONED, this field is required. Amazon has guidelines for specifying the Stream size that should be referenced when creating a Kinesis stream | `number` | `null` | no |
| <a name="input_shard_level_metrics"></a> [shard\_level\_metrics](#input\_shard\_level\_metrics) | A list of shard-level CloudWatch metrics which can be enabled for the stream | `list(string)` | `null` | no |
| <a name="input_stage"></a> [stage](#input\_stage) | ID element. Usually used to indicate role, e.g. 'prod', 'staging', 'source', 'build', 'test', 'deploy', 'release' | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags (e.g. `{'BusinessUnit': 'XYZ'}`).<br>Neither the tag keys nor the tag values will be modified by this module. | `map(string)` | `{}` | no |
| <a name="input_tenant"></a> [tenant](#input\_tenant) | ID element \_(Rarely used, not included by default)\_. A customer identifier, indicating who this instance of a resource is for | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_kinesis_stream_arn"></a> [kinesis\_stream\_arn](#output\_kinesis\_stream\_arn) | ARN for the created kinesis stream |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
