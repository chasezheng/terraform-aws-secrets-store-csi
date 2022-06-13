data "aws_region" "current" {
}

data "aws_caller_identity" "current" {
}

data "http" "ascp_manifest" {
  url = "https://raw.githubusercontent.com/aws/secrets-store-csi-driver-provider-aws/main/deployment/aws-provider-installer.yaml"
}
