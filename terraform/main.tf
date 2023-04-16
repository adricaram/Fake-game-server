provider "kubernetes" {
  config_path = "~/.kube/config"
}

resource "kubernetes_namespace" "game" {
  metadata {
    name = "game"
  }
}

resource "kubernetes_config_map" "server-config" {
  metadata {
    name      = "server-config"
    namespace = kubernetes_namespace.game.metadata.0.name
  }

  data = {
    SERVER_IP   = "0.0.0.0"
    SERVER_PORT = "7778"
  }
}

resource "kubernetes_deployment" "server" {
  metadata {
    name      = "server"
    namespace = kubernetes_namespace.game.metadata.0.name
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

          env {
            name  = "PYTHONUNBUFFERED"
            value = "1"
          }

          env {
            name = "SERVER_IP"
            value_from {
              config_map_key_ref {
                name = kubernetes_config_map.server-config.metadata.0.name
                key  = "SERVER_IP"
              }
            }
          }

          env {
            name = "SERVER_PORT"
            value_from {
              config_map_key_ref {
                name = kubernetes_config_map.server-config.metadata.0.name
                key  = "SERVER_PORT"
              }
            }
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
    name      = "server"
    namespace = kubernetes_namespace.game.metadata.0.name
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
