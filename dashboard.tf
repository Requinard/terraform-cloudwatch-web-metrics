resource "aws_cloudwatch_dashboard" "dashboard" {
  dashboard_name = replace("${var.namespace}-dashboard", "/", "-")

  dashboard_body = jsonencode({
    widgets = [
      {
        type: "metric",
        x: 0,
        y: 0,
        width: 12,
        height: 9,
        properties: {
          metrics: concat(
          [
            [
              var.namespace,
              local.metrics.requests_total
            ],
            [
              var.namespace,
              local.metrics.exception_occured
            ]
          ],
          [for item in var.request_types: [var.namespace, "Requests${item}"]]
          ),
          period: 60
          stat: "Sum"
          title: "Requests by type",
          region: "eu-central-1",
          stacked: true,
          legend: {
            position: "right"
          }
        }
      },
      {
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
          stacked: true,
          legend: {
            position: "right"
          }
        }
      },
      {
        type: "metric",
        x: 0,
        y: 9,
        width: 24,
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
            position: "right"
          }
        }
      },
    ]
  })
}
