resource "helm_release" "prometheus" {
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
  name             = "grafana"
  chart            = "grafana"
  repository       = "https://grafana.github.io/helm-charts"
  namespace        = "monitoring"
  create_namespace = false
}
