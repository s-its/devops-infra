resource "helm_release" "istio_base" {
  name       = "istio-base"
  namespace  = "istio-system"
  repository = "https://istio-release.storage.googleapis.com/charts"
  chart      = "base"

  create_namespace = true
}

resource "helm_release" "istio_discovery" {
  name      = "istiod"
  namespace = "istio-system"
  repository = "https://istio-release.storage.googleapis.com/charts"
  chart      = "istiod"

  depends_on = [helm_release.istio_base]
}

resource "helm_release" "istio_ingress" {
  name      = "istio-ingressgateway"
  namespace = "istio-system"
  repository = "https://istio-release.storage.googleapis.com/charts"
  chart      = "gateway"

  set {
    name  = "service.type"
    value = "NodePort"
  }

  depends_on = [helm_release.istio_discovery]
}

resource "aws_lb" "alb" {
  name               = "eks-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = [for s in data.aws_subnet.public_subnet : s.id]
  tags = {
    Name = "eks-alb"
  }
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = aws_acm_certificate.ssl.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.istio.arn
  }
}

resource "aws_lb_target_group" "istio" {
  name        = "istio-ingress-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = data.aws_vpc.eks_vpc.id

  health_check {
    path                = "/healthz/ready"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    protocol            = "HTTP"
  }
}

resource "aws_route53_record" "app_records" {
  for_each = var.applications

  zone_id = data.aws_route53_zone.main.zone_id
  name    = "${each.value}.${var.domain_name}"
  type    = "A"

  alias {
    name                   = aws_lb.alb.dns_name
    zone_id                = aws_lb.alb.zone_id
    evaluate_target_health = false
  }
}

resource "kubernetes_manifest" "istio_service_entries" {
  for_each = var.applications

  manifest = <<EOF
apiVersion: networking.istio.io/v1alpha3
kind: VirtualService
metadata:
  name: ${each.key}
  namespace: istio-system
spec:
  hosts:
    - "${each.value}.${var.domain_name}"
  gateways:
    - istio-ingressgateway
  http:
    - route:
      - destination:
          host: ${each.key}.${var.domain_name}
          port:
            number: 80
EOF
}
