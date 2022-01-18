terraform {
  required_providers {
    rabbitmq = {
      source  = "cyrilgdn/rabbitmq"
      version = "1.6.0"
    }
  }
}

resource "rabbitmq_exchange" "test" {

  name  = var.exchange_name
  vhost = var.vhost_name

  settings {
    type        = var.exchange_type
    durable     = var.durable
    auto_delete = var.auto_delete
    arguments   = var.arguments
  }
}