module "vhost" {
  source     = "./module/vhost"
  vhost_name = var.vhostname
  permission = {
    configure = ".*"
    write     = ".*"
    read      = ".*"
  }
}


module "exchange" {
  source        = "./module/exchange"
  vhost_name    = module.vhost.name
  exchange_name = "test"
  exchange_type = "direct"
  durable       = false
  auto_delete   = true

  depends_on = [
    module.vhost
  ]
}
module "queue" {
  source      = "./module/queue"
  vhost_name  = module.vhost.name
  queue_name  = "test"
  durable     = false
  auto_delete = true

  depends_on = [
    module.vhost
  ]
}


module "binding" {
  source           = "./module/binding"
  source_name      = module.exchange.name
  vhost_name       = module.vhost.name
  destination      = module.queue.name
  destination_type = "queue"
  routing_key      = "#"

  depends_on = [
    module.vhost,
    module.queue,
    module.exchange

  ]
}
