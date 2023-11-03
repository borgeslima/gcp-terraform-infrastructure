provider "helm" {
  kubernetes {
    host                   = "https://${module.google_container_cluster.endpoint}"
    token                  = module.google_container_cluster.access_token
    cluster_ca_certificate = base64decode(module.google_container_cluster.cluster_ca_certificate)
  }
}

resource "helm_release" "helm" {

  for_each = try(var.helms, {})

  name             = each.value.name
  repository       = each.value.repository
  chart            = each.value.chart
  namespace        = each.value.namespace
  force_update     = each.value.force_update
  cleanup_on_fail  = each.value.cleanup_on_fail
  create_namespace = each.value.create_namespace
  wait             = each.value.wait
  timeout          = each.value.timeout

  values = [
    "${file("${each.value.values}")}",
  ]

  depends_on = [
    module.google_container_cluster,
    module.google_container_node_pool
  ]
}