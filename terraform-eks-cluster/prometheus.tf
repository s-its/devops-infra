resource "helm_release" "prometheus" {
  count = var.enable_monitoring ? 1 : 0
  name       = "prometheus-community"
  chart      = "prometheus"
  repository = "https://prometheus-community.github.io/helm-charts"
  namespace  = "prometheus"

  create_namespace = true

  values = [
    file("./prometheus-values.yaml") # Optional custom values file
  ]
}
