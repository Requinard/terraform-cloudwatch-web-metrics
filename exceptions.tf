resource "aws_cloudwatch_log_metric_filter" "errors" {
  # Logs all items with the Exception match
  log_group_name = var.log_group_name
  name           = "Exceptions"
  pattern        = var.pattern_exception

  metric_transformation {
    name      = local.metric_exception_occured
    namespace = var.namespace
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_alarm" "errors" {
  alarm_name        = "${var.namespace}/ErrorOccurred"
  alarm_description = "Monitors the exceptions occurring in this log group"

  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  period              = var.period
  threshold           = var.threshold_exceptions
  metric_name         = local.metric_exception_occured
  statistic           = "Average"
  namespace           = var.namespace

  #  TODO: This has been removed for the time being as I cannot yet get the metrics query to work
  #  metric_query {
  #    id = "errors"
  #
  #    metric {
  #      metric_name = aws_cloudwatch_log_metric_filter.requests_total.name
  #      namespace   = var.namespace
  #      period      = var.period
  #      stat        = "SUM"
  #      unit        = "Count"
  #    }
  #  }
  #
  #  metric_query {
  #    id = "requests"
  #
  #    metric {
  #      metric_name = aws_cloudwatch_log_metric_filter.errors.name
  #      namespace   = var.namespace
  #      period      = var.period
  #      stat        = "SUM"
  #      unit        = "Count"
  #    }
  #  }
  #
  #  metric_query {
  #    id          = "errorRate"
  #    expression  = "100"
  #    return_data = true
  #  }
}
