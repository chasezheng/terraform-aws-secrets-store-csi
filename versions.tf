terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.18"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.5"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.11"
    }
    http = {
      source  = "hashicorp/http"
      version = ">= 2.2.0"
    }
  }
}
