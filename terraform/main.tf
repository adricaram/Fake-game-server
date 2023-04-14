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

          port {
            container_port = 12345
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

    type = "NodePort"

    port {
      port        = 12345
      target_port = 12345
    }
  }
}
