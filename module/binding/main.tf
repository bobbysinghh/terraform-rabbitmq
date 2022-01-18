terraform {
  required_providers {
    rabbitmq = {
      source  = "cyrilgdn/rabbitmq"
      version = "1.6.0"
    }
  }
}

resource "rabbitmq_binding" "test" {
  source           = var.source_name
  vhost            = var.vhost_name
  destination      = var.destination
  destination_type = var.destination_type
  routing_key      = var.routing_key
  arguments        = var.arguments
}