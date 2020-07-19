provider aws {
  region  = "eu-central-1"
  profile = "requinard"
}

terraform {
  backend "s3" {
    profile = "requinard"
    bucket  = "requinard-terraform"
    region  = "eu-central-1"
    key     = "modules/terrafom-webapp-metrics"
    encrypt = true
  }
}

resource "aws_cloudwatch_log_group" "group" {
  name              = "webapp-metrics-testing-${terraform.workspace}"
  retention_in_days = 1
}

module "metrics" {
  source = "../"

  log_group_name = aws_cloudwatch_log_group.group.name
  namespace      = "metrics-testing/${terraform.workspace}"
}
