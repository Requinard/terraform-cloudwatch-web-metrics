resource "aws_cloudwatch_dashboard" "dashboard" {
  dashboard_name = var.dashboard_name

  dashboard_body = jsonencode({
    widgets = [
      {
        type: "metric",
        x: 0,
        y: 0,
        width: 12,
        height: 6,
        properties: {
          metrics: [
            [
              var.namespace,
              local.metrics.requests_total
            ],
            [
              var.namespace,
              local.metrics.exception_occured
            ]
          ],
          period: 60
          stat: "Sum"
          title: "Request Counts",
          region: "eu-central-1"
        }
      },
      {
        type: "metric",
        x: 0,
        y: 6,
        width: 12,
        height: 6,
        properties: {
          metrics: [
            [
              var.namespace,
              var.status_code_metrics.500
            ],
            [
              var.namespace,
              var.status_code_metrics.409
            ],
            [
              var.namespace,
              var.status_code_metrics.401
            ],
            [
              var.namespace,
              var.status_code_metrics.403
            ],
            [
              var.namespace,
              var.status_code_metrics.404
            ]
          ],
          period: 60
          stat: "Sum"
          title: "Bad Status Codes",
          region: "eu-central-1"
        }
      }
    ]
  })
}
