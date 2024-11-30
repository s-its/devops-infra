resource "helm_release" "istio_base" {
  name       = "istio-base"
  namespace  = "istio-system"
  repository = "https://istio-release.storage.googleapis.com/charts"
  chart      = "base"

  create_namespace = true
}

resource "helm_release" "istio_discovery" {
  name       = "istiod"
  namespace  = "istio-system"
  repository = "https://istio-release.storage.googleapis.com/charts"
  chart      = "istiod"

  depends_on = [helm_release.istio_base]
}

resource "helm_release" "istio_ingress" {
  name       = "istio-ingressgateway"
  namespace  = "istio-system"
  repository = "https://istio-release.storage.googleapis.com/charts"
  chart      = "gateway"

  set {
    name  = "service.type"
    value = "NodePort"
  }

  depends_on = [helm_release.istio_discovery]
}


