#resource "rabbitmq_vhost" "test" {
#  name = var.vhost
#}

# resource "rabbitmq_permissions" "guest" {
#   user  = var.user_name
#   vhost = "${rabbitmq_vhost.test.name}"

#   permissions {
#     configure = ".*"
#     write     = ".*"
#     read      = ".*"
#   }
# }

#resource "rabbitmq_exchange" "test" {
#  for_each = var.exchange
# name  = "${each.value.name}"
#vhost = "${rabbitmq_permissions.guest.vhost}"
#
# settings {
#  type        = "${each.value.type}"
# durable     = each.value.durable
#auto_delete = each.value.auto_delete
#}
#}

# resource "rabbitmq_queue" "test" {
#   name  = var.queue_name
#   vhost = "${rabbitmq_permissions.guest.vhost}"

#   settings {
#     durable     = true
#     auto_delete = false
#   }
# }

# resource "rabbitmq_binding" "test" {
#   source           = "${rabbitmq_exchange.test.name}"
#   vhost            = "${rabbitmq_vhost.test.name}"
#   destination      = "${rabbitmq_queue.test.name}"
#   destination_type = "queue"
#   routing_key      = "#"
# }