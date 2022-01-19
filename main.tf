# module "vhost" {
#   source     = "./module/vhost"
#   vhost_name = var.vhostname
#   permission = {
#     configure = ".*"
#     write     = ".*"
#     read      = ".*"
#   }
# }


# module "exchange" {
#   source        = "./module/exchange"
#   vhost_name    = module.vhost.name
#   exchange_name = "test"
#   exchange_type = "direct"
#   durable       = false
#   auto_delete   = true

#   depends_on = [
#     module.vhost
#   ]
# }
# module "queue" {
#   source      = "./module/queue"
#   vhost_name  = module.vhost.name
#   queue_name  = "test"
#   durable     = false
#   auto_delete = true

#   depends_on = [
#     module.vhost
#   ]
# }


# module "binding" {
#   source           = "./module/binding"
#   source_name      = module.exchange.name
#   vhost_name       = module.vhost.name
#   destination      = module.queue.name
#   destination_type = "queue"
#   routing_key      = "#"

#   depends_on = [
#     module.vhost,
#     module.queue,
#     module.exchange

#   ]
# }


module "complete" {
  source       = "./module/complete"
  user_name    = var.user_name
  create_vhost = true
  vhost_name   = var.vhostname
  exchange = {
    "test" = "direct"
  }
  queue = {
    webhook-analysis-queue = {
      "x-queue-type" : "classic"
    },
    authorization-session = {
      "x-message-ttl" : 600000,
      "x-dead-letter-exchange" : "authorization.session.exchange",
      "x-dead-letter-routing-key" : "authorization-session-dlq-queue",
      "x-queue-type" : "classic"
  } }

  binding = {
    #  destination  = source  
    "webhook-analysis-queue" = "test"

  }

}