resource "helm_release" "calico" {
  depends_on = [module.eks]
  name       = "calico"
  namespace  = "calico"
  repository = "https://projectcalico.docs.tigera.io/charts"
  chart      = "tigera-operator"

  create_namespace = true
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


resource "kubernetes_manifest" "calico_cr" {
  depends_on = [module.eks]
  manifest   = yamldecode(file("./calico-cr.yaml"))
}

