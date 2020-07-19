variable "log_group_name" {
  type        = string
  description = "The name of an AWS Cloudwatch Log Group"
}

variable "namespace" {
  type        = string
  description = "A account-unique identifier for this application and environment. (frontoffice/master, generic-es/dev)"
}

variable "threshold_exceptions" {
  type        = number
  description = "The percentage of errors that should trigger the alarm"
  default     = 1
}

variable "pattern_exception" {
  default     = "Exception"
  description = "The pattern for an Exception in cloudwatch"
  type        = string
}

variable "period" {
  type        = number
  description = "The period to check over"
  default     = 120
}

variable "health_endpoint" {
  type        = string
  description = "A pattern that is automatically excluded from all request counts"
  default     = "health"
}

variable "alarm_actions" {
  type        = list(string)
  default     = []
  description = "A list of ARNs to execute in case of alarms"
}

variable "status_code_metrics" {
  type        = map(string)
  description = "Status codes and their maps"

  default = {
    401: "Status401NotAuthorized",
    403: "Status403NotAuthenticated",
    404: "Status404NotFound",
    409: "Status409Conflict",
    500: "Status500UncaughtInternalError"
  }
}

locals {
  request_types = ["GET", "POST", "PUT", "PATCH", "DELETE"]
  metrics       = {
    exception_occured = "ExceptionsOccurred"
    requests_total    = "RequestsTotal"
    request_type      = "Requests"
  }
}
