#region Widgets
output "widget_unhandled_exceptions" {
  value = local.widgets.unhandled_exceptions
}

output "widget_total_requests" {
  value = local.widgets.total_requests
}

output "widget_requests_by_type" {
  value = local.widgets.requests_by_type
}

output "widget_bad_status_codes" {
  value = local.widgets.bad_status_codes
}
#endregion
