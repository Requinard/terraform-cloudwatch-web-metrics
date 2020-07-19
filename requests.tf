resource "aws_cloudwatch_log_metric_filter" "request_method_counts" {
  # Takes a raw per-request count
  count = length(local.request_types)

  log_group_name = var.log_group_name
  name           = "Requests${local.request_types[count.index]}"
  pattern        = "${local.request_types[count.index]} -${var.health_endpoint}" # Exclude health endpoint

  metric_transformation {
    name      = "${local.metrics.request_type}${local.request_types[count.index]}"
    namespace = var.namespace
    value     = "1"
  }
}

resource "aws_cloudwatch_log_metric_filter" "requests_total" {
  log_group_name = var.log_group_name
  name           = local.metrics.requests_total
  pattern        = "${join(" ", formatlist("?%s", local.request_types))} -${var.health_endpoint}"

  metric_transformation {
    name      = local.metrics.requests_total
    namespace = var.namespace
    value     = "1"
  }
}
