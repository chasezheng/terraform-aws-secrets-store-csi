locals {
  service_account_name = var.service_account_name

  values = {
    image_repository = var.image_repository
    image_tag        = var.image_tag

    resources_driver    = jsonencode(var.resources_driver)
    resources_registrar = jsonencode(var.resources_registrar)
    resources_liveness  = jsonencode(var.resources_liveness)

  }
}

resource "helm_release" "release" {
  name       = var.release_name
  chart      = var.chart_name
  repository = var.chart_repository
  version    = var.chart_version
  namespace  = var.chart_namespace

  max_history = var.max_history
  timeout     = var.chart_timeout

  values = [
    templatefile("${path.module}/templates/values.yaml", local.values),
  ]
}

resource "kubernetes_manifest" "ascp" {
  manifest = yamldecode(var.ascp_manifest_url)
}
