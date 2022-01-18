terraform {
  required_providers {
    rabbitmq = {
      source  = "cyrilgdn/rabbitmq"
      version = "1.6.0"
    }
  }
}
resource "rabbitmq_queue" "test" {
  name  = var.queue_name
  vhost = var.vhost_name


  settings {
    durable     = var.durable
    auto_delete = var.auto_delete
    arguments   = var.arguments
  }
}
