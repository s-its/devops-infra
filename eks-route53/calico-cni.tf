resource "helm_release" "calico_operator" {
  name       = "calico"
  chart      = "tigera-operator"
  namespace  = "calico"
  repository = "https://docs.tigera.io/calico/charts"
  version    = "v3.26.0" # Update to the desired Calico version

  create_namespace = true
  set {
    name  = "installation.calicoNetwork.ipPools[0].cidr"
    value = "192.168.0.0/16"
  }
}

/*resource "kubernetes_manifest" "calico_cr" {
  depends_on = [aws_eks_cluster.cluster]
  manifest = {
    apiVersion = "operator.tigera.io/v1"
    kind       = "Installation"
    metadata = {
      name = "default"
    }
    spec = {
      cni = {
        type = "Calico"
      }
      calicoNetwork = {
        ipPools = [
          {
            blockSize    = 26
            cidr         = "192.168.0.0/16"
            encapsulation = "VXLAN"
            natOutgoing  = "Enabled"
            nodeSelector = "all()"
          }
        ]
      }
    }
  }
}*/


/*resource "kubernetes_manifest" "calico_cr" {
  manifest   = yamldecode(file("./calico-cr.yaml"))
}*/

