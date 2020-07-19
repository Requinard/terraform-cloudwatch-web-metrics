resource "aws_cloudwatch_dashboard" "dashboard" {
  count = var.create_dashboard ? 1 : 0

  dashboard_name = replace("${var.namespace}-dashboard", "/", "-")

  dashboard_body = jsonencode({
    widgets = [
      local.widgets.requests_by_type,
      local.widgets.bad_status_codes,
      local.widgets.total_requests,
      local.widgets.unhandled_exceptions
    ]
  })
}

locals {
  widgets = {
    requests_by_type     = {
      type: "metric",
      x: 0,
      y: 0,
      width: 12,
      height: 9,
      properties: {
        metrics: [for item in var.request_types: [var.namespace, "Requests${item}"]],
        period: 60
        stat: "Sum"
        title: "Requests by type",
        region: "eu-central-1",
        stacked: true
      }
    }
    unhandled_exceptions = {
      type: "metric",
      x: 12,
      y: 9,
      width: 12,
      height: 6,
      properties: {
        metrics:[
          [
            var.namespace,
            local.metrics.exception_occured
          ]
        ],
        period: 60
        stat: "Sum"
        title: "Unhandled Exceptions",
        region: "eu-central-1",
        stacked: true,
        legend: {
          position: "hidden"
        }
      }
    }
    total_requests       = {
      type: "metric",
      x: 0,
      y: 9,
      width: 12,
      height: 6,
      properties: {
        metrics:[
          [
            var.namespace,
            local.metrics.requests_total
          ]
        ],
        period: 60
        stat: "Sum"
        title: "Total Requests",
        region: "eu-central-1",
        stacked: true,
        legend: {
          position: "hidden"
        }
      }
    }
    bad_status_codes     = {
      type: "metric",
      x: 12,
      y: 0,
      width: 12,
      height: 9,
      properties: {
        metrics:[for item in var.status_code_metrics: [var.namespace, item]],
        period: 60
        stat: "Sum"
        title: "Bad Status Codes",
        region: "eu-central-1",
        stacked: true
      }
    },
  }
}
