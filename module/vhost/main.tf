terraform {
  required_providers {
    rabbitmq = {
      source  = "cyrilgdn/rabbitmq"
      version = "1.6.0"
    }
  }
}

resource "rabbitmq_vhost" "test" {
  name = var.vhost_name
}

resource "rabbitmq_permissions" "guest" {
  user  = var.user_name
  vhost = rabbitmq_vhost.test.name

  permissions {
    configure = lookup(var.permission, "configure", ".*")
    write     = lookup(var.permission, "write", ".*")
    read      = lookup(var.permission, "read", ".*")
  }
}
