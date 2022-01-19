resource "rabbitmq_vhost" "test" {
  count = var.create_vhost == true ? 1 : 0
  name  = var.vhost_name
}

resource "rabbitmq_permissions" "guest" {
  user  = var.user_name
  vhost = var.vhost_name == "" ? "${rabbitmq_vhost.test[0].name}" : var.vhost_name

  permissions {
    configure = ".*"
    write     = ".*"
    read      = ".*"
  }
}

resource "rabbitmq_exchange" "test" {
  for_each = var.exchange
  name     = each.key
  vhost    = rabbitmq_permissions.guest.vhost
  settings {
    type        = each.value
    durable     = true
    auto_delete = false

  }
  depends_on = [
    rabbitmq_permissions.guest
  ]
}

resource "rabbitmq_queue" "test" {
  for_each = var.queue
  name     = each.key
  vhost    = rabbitmq_permissions.guest.vhost

  settings {
    durable        = true
    auto_delete    = false
    arguments_json = jsonencode(each.value)
  }
  depends_on = [
    rabbitmq_permissions.guest
  ]
}

resource "rabbitmq_binding" "test" {
  for_each         = var.binding
  source           = each.value
  vhost            = rabbitmq_vhost.test[0].name
  destination      = each.key
  destination_type = "queue"
  routing_key      = "#"
  depends_on = [
    rabbitmq_exchange.test,
    rabbitmq_permissions.guest,
    rabbitmq_queue.test

  ]
}