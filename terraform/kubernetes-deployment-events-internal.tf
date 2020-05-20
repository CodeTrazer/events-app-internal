resource "kubernetes_deployment" "events-internal-deployment" {
  metadata {
    name = "events-internal-deployment"
    labels = {
      App = "events-internal"
    }
    namespace = kubernetes_namespace.n.metadata[0].name
  }

  spec {
    replicas                  = 2
    progress_deadline_seconds = 60
    selector {
      match_labels = {
        App = "events-internal"
      }
    }
    template {
      metadata {
        labels = {
          App = "events-internal"
        }
      }
      spec {
        container {
          image = "gcr.io/dtc-user108/internal-image:v1.0.0"
          name  = "events-internal"

          port {
            container_port = 8082
          }

          resources {
            limits {
              cpu    = "0.2"
              memory = "2562Mi"
            }
            requests {
              cpu    = "0.1"
              memory = "50Mi"
            }
          }
        }
      }
    }
  }
}