terraform {
  required_providers {
    rabbitmq = {
      source  = "cyrilgdn/rabbitmq"
      version = "1.6.0"
    }
  }
}

provider "rabbitmq" {
  # Configuration options
  endpoint = "http://127.0.0.1:8080"
  username = "guest"
  password = "guest"
}


