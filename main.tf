locals {
  service_account_name = var.service_account_name

  manifest_split = [for data in split("---", data.http.ascp_manifest.body) : yamldecode(data)]
}

resource "helm_release" "release" {
  name             = var.release_name
  chart            = var.chart_name
  repository       = var.chart_repository
  version          = var.chart_version
  namespace        = var.chart_namespace
  max_history      = var.max_history
  timeout          = var.chart_timeout
  atomic           = true
  cleanup_on_fail  = true
  reset_values     = true
  force_update     = true
  replace          = var.replace
  create_namespace = true
  lint             = true
  wait             = var.wait
  wait_for_jobs    = var.wait_for_jobs

  dynamic "set" {
    for_each = var.set
    content {
      name  = set.key
      value = set.value
      type  = "auto"
    }
  }

  dynamic "set_sensitive" {
    for_each = var.set_sensitive
    content {
      name  = set_sensitive.key
      value = set_sensitive.value
      type  = "auto"
    }
  }

}

resource "kubernetes_manifest" "ascp" {
  count    = var.ascp_manifest_parts
  manifest = local.manifest_split[count.index]

  depends_on = [helm_release.release]

  lifecycle {
    # The AMI ID must refer to an existing AMI that has the tag "nomad-server".
    precondition {
      condition     = length(local.manifest_split) == var.ascp_manifest_parts
      error_message = "Please update var.ascp_manifest_parts = ${length(local.manifest_split)}"
    }
  }
}
