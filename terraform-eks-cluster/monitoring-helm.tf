resource "helm_release" "prometheus" {
  count = var.enable_monitoring ? 1 : 0
  name       = "prometheus"
  chart      = "prometheus"
  repository = "https://prometheus-community.github.io/helm-charts"
  namespace  = "monitoring"

  create_namespace = true

  values = [
    file("./prometheus-values.yaml") # Optional custom values file
  ]
}

resource "helm_release" "grafana" {
  count = var.enable_monitoring ? 1 : 0
  name       = "grafana"
  chart      = "grafana"
  repository = "https://grafana.github.io/helm-charts"
  namespace  = "monitoring"
  create_namespace = false
}
