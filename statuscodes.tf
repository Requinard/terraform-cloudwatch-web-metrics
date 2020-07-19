resource "aws_cloudwatch_log_metric_filter" "status_codes" {
  # Report on the status codes
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

resource "aws_cloudwatch_metric_alarm" "status_codes" {
  for_each = var.status_code_metrics

  alarm_name        = "${var.namespace}/${each.value}"
  alarm_description = "Monitors for status code ${each.key}"

  metric_name         = each.value
  namespace           = var.namespace
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  period              = 120
  statistic           = "Average"
  threshold           = var.threshold_status_codes

  alarm_actions = var.alarm_actions

  # todo make this percentage of errors
}

