provider "kubernetes" {
  config_path = "~/.kube/config"
}

resource "kubernetes_deployment" "server" {
  metadata {
    name = "server"
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "server"
      }
    }

    template {
      metadata {
        labels = {
          app = "server"
        }
      }

      spec {
        container {
          name  = "server"
          image = "jackypaul06/server:latest"

          # Add the PYTHONUNBUFFERED environment variable
          env {
            name  = "PYTHONUNBUFFERED"
            value = "1"
          }

          port {
            container_port = 7778
            protocol       = "UDP"
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "server" {
  metadata {
    name = "server"
  }

  spec {
    selector = {
      app = "server"
    }

    type = "LoadBalancer"

    port {
      protocol    = "UDP"
      port        = 7778
      target_port = 7778
    }
  }
}

