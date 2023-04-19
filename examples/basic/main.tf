module "example" {
  source = "../.."

  namespace   = "namespace"
  environment = "environment"
  stage       = "stage"
  name        = "kinesis"
  attributes  = ["foo"]

  alarm_create = false
}
