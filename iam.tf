module "secrets_manager_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "~> 4.21.1"

  role_name_prefix = coalesce(var.iam_role_name, "${var.cluster_name}-sm-csi-")
  role_description = "EKS Cluster ${var.cluster_name} Secret Manager CSI Driver role"

  attach_external_secrets_policy        = true
  external_secrets_secrets_manager_arns = ["arn:aws:secretsmanager:${local.region}:${data.aws_caller_identity.current.account_id}:secret:*"]

  oidc_providers = {
    main = {
      provider_arn               = var.oidc_provider_arn
      namespace_service_accounts = ["kube-system:${local.service_account_name}"]
    }
  }
}
