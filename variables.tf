variable "cluster_name" {
  description = "Name of Kubernetes Cluster"
  type        = string
}

variable "region" {
  description = "The AWS region for the kubernetes cluster. Set to use KIAM or kube2iam for example."
  type        = string
  default     = ""
}

variable "release_name" {
  description = "Helm release name"
  type        = string
  default     = "secrets-store-csi-driver"
}

variable "chart_name" {
  description = "Helm chart name to provision"
  type        = string
  default     = "secrets-store-csi-driver"
}

variable "chart_repository" {
  description = "Helm repository for the chart"
  type        = string
  default     = "https://kubernetes-sigs.github.io/secrets-store-csi-driver/charts"
}

variable "chart_version" {
  description = "Version of Chart to install. Set to empty to install the latest version"
  type        = string
  default     = "1.1.2"
}

variable "chart_namespace" {
  description = "Namespace to install the chart into"
  type        = string
  default     = "kube-system"
}

variable "chart_timeout" {
  description = "Timeout to wait for the Chart to be deployed."
  type        = number
  default     = 300
}

variable "max_history" {
  description = "Max History for Helm"
  type        = number
  default     = 20
}

variable "replace" {
  type    = bool
  default = false
}

variable "wait" {
  type    = bool
  default = true
}

variable "wait_for_jobs" {
  type    = bool
  default = false
}

variable "set" {
  type    = map(string)
  default = {}
}

variable "set_sensitive" {
  type    = map(string)
  default = {}
}

########################
# Chart Values
########################

variable "image_repository" {
  description = "Image repository on Dockerhub"
  type        = string
  default     = "k8s.gcr.io/csi-secrets-store/driver"
}

variable "image_tag" {
  description = "Image tag"
  type        = string
  default     = "v1.1.2"
}


###########
## ASCP ###
###########

variable "ascp_manifest_url" {
  description = "ASCP YAML file in the GitHub repo deployment directory"
  type        = string
  default     = "https://raw.githubusercontent.com/aws/secrets-store-csi-driver-provider-aws/a31a8a3be9200c46ec5cc0b613c33e6e1b33c916/deployment/aws-provider-installer.yaml"
}

variable "ascp_manifest_parts" {
  type    = number
  default = 4
}

########################
# IAM Role
########################
variable "oidc_provider_arn" {
  description = "OIDC Provider ARN for IRSA"
  type        = string
}

variable "iam_role_name" {
  description = "Name of IAM role for controller"
  type        = string
  default     = ""
}

variable "iam_role_description" {
  description = "Description for IAM role for controller"
  type        = string
  default     = "Used by AWS Load Balancer Controller for EKS"
}

variable "iam_role_path" {
  description = "IAM Role path for controller"
  type        = string
  default     = ""
}

variable "iam_role_permission_boundary" {
  description = "Permission boundary ARN for IAM Role for controller"
  type        = string
  default     = ""
}

variable "iam_role_tags" {
  description = "Tags for IAM Role for controller"
  type        = map(string)
  default     = {}
}

variable "iam_role_policy" {
  description = "Override the IAM policy for the controller"
  type        = string
  default     = ""
}

##############
#### IRSC ####
##############
variable "service_account_name" {
  description = "Name of service account to create. Not generated"
  type        = string
  default     = "csi-secrets-store-provider-aws"
}

variable "external_secrets_ssm_parameter_arns" {
  description = "List of Systems Manager Parameter ARNs that contain secrets to mount using External Secrets"
  type        = list(string)
  default     = ["arn:aws:ssm:*:*:parameter/*"]
}

variable "external_secrets_secrets_manager_arns" {
  description = "List of Secrets Manager ARNs that contain secrets to mount using External Secrets"
  type        = list(string)
  default     = ["arn:aws:secretsmanager:*:*:secret:*"]
}

variable "create_default_irsa" {
  description = "Create default IRSA for service account"
  type        = bool
  default     = true
}

variable "namespace" {
  description = "Kubernetes namespace, where the service account want to create"
  type        = string
  default     = "default"
}
