resource "aws_cloudwatch_log_metric_filter" "status_codes" {
  for_each = var.status_code_metrics

  log_group_name = var.log_group_name
  name           = each.value
  pattern        = each.key

  metric_transformation {
    name      = each.value
    namespace = var.namespace
    value     = "1"
  }
}
