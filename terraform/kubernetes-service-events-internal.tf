resource "kubernetes_service" "events-internal-service" {
  metadata {
    name      = "events-internal-service"
    namespace = kubernetes_namespace.n.metadata[0].name
  }
  spec {
    selector = {
      App = kubernetes_deployment.events-internal-deployment.spec.0.template.0.metadata[0].labels.App
    }
    port {
      port        = 80
      target_port = 8082
    }
    type = "ClusterIP"
  }
}

output "events-internal-service-ip" {
  value = kubernetes_service.events-internal-service.spec[0].cluster_ip
}