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
    "authorization.session.exchange" = "direct",
    "crawler.webhook.exchange"       = "direct",
    "main.webhook.exchange"          = "direct",
    "main.retry.exchange"            = "direct"
  }
  queue = {
    authorization-session-dlq-queue = {
      "x-queue-type" = "classic"
    },
    authorization-session = {
      "x-message-ttl"             = 600000,
      "x-dead-letter-exchange"    = "authorization.session.exchange",
      "x-dead-letter-routing-key" = "authorization-session-dlq-queue",
      "x-queue-type"              = "classic"
    },
    webhook-main-queue = {},
    webhook-analysis-queue = {
      "x-queue-type" = "classic"
    },
    crawler-main-queue = {}
    webhook-queue-retry-1 = {
      "x-message-ttl"             = 300000,
      "x-dead-letter-exchange"    = "main.retry.exchange",
      "x-dead-letter-routing-key" = "webhook-queue-retry-2",
      "x-queue-type"              = "classic"
    },
    webhook-queue-retry-2 = {
      "x-message-ttl"             = 3600000,
      "x-dead-letter-exchange"    = "main.retry.exchange",
      "x-dead-letter-routing-key" = "webhook-queue-retry-3",
    "x-queue-type" = "classic" },
    webhook-queue-retry-3 = {
      "x-message-ttl"             = 7200000,
      "x-dead-letter-exchange"    = "main.retry.exchange",
      "x-dead-letter-routing-key" = "webhook-queue-dead",
      "x-queue-type"              = "classic"
    }
    webhook-queue-dead = {}

  }

  binding = {
    #  destination  = {source = "xxxxxx" ,routing_key = "xxxxxx" }  
    "webhook-analysis-queue"          = { source = "authorization.session.exchange", routing_key = "authorization-session" },
    "authorization-session-dlq-queue" = { source = "authorization.session.exchange", routing_key = "authorization-session-dlq-queue" },
    "crawler-main-queue"              = { source = "crawler.webhook.exchange", routing_key = "crawler-main-queue" },
    #"crawler-main-queue"              = {source="crawler.webhook.exchange" ,routing_key = null},
    "webhook-analysis-queue" = { source = "main.webhook.exchange", routing_key = "webhook-analysis-queue" },
    "webhook-main-queue"     = { source = "main.webhook.exchange", routing_key = "webhook-main-queue" },
    "webhook-queue-retry-1"  = { source = "main.retry.exchange", routing_key = "webhook-queue-retry-1" },
    "webhook-queue-retry-2"  = { source = "main.retry.exchange", routing_key = "webhook-queue-retry-2" },
    "webhook-queue-retry-3"  = { source = "main.retry.exchange", routing_key = "webhook-queue-retry-3" },
    "webhook-queue-dead"     = { source = "main.retry.exchange", routing_key = "webhook-queue-dead" }


  }

}