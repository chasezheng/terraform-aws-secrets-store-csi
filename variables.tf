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

variable "resources_driver" {
  description = "Driver Resources"
  type        = map(any)
  default = {
    requests = {
      cpu    = "200m"
      memory = "200Mi"
    }
    limits = {
      cpu    = "200m"
      memory = "200Mi"
    }
  }
}

variable "resources_registrar" {
  description = "Registrar Resources"
  type        = map(any)
  default = {
    requests = {
      cpu    = "100m"
      memory = "100Mi"
    }
    limits = {
      cpu    = "100m"
      memory = "100Mi"
    }
  }
}

variable "resources_liveness" {
  description = "LivenessProbe Resources"
  type        = map(any)
  default = {
    requests = {
      cpu    = "100m"
      memory = "100Mi"
    }
    limits = {
      cpu    = "100m"
      memory = "100Mi"
    }
  }
}

###########
## ASCP ###
###########

variable "ascp_manifest_url" {
  description = "ASCP YAML file in the GitHub repo deployment directory"
  type        = string
  default     = "https://raw.githubusercontent.com/aws/secrets-store-csi-driver-provider-aws/main/deployment/aws-provider-installer.yaml"
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

variable "namespace_service_accounts" {
  description = "Name of service account to add for other namespace"
  type        = list(string)
  default     = ["drupal-dev:csi-secrets-store-provider-aws"]
}
