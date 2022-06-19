data "aws_region" "current" {
}

data "aws_caller_identity" "current" {
}

data "http" "ascp_manifest" {
  url = var.ascp_manifest_url
}
