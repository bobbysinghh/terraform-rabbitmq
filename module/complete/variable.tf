variable "create_vhost" {
  type    = bool
  default = false
}

variable "vhost_name" {
  type    = string
  default = ""
}
variable "user_name" {
  type    = string
  default = "guest"

}
variable "exchange" {
  type = map(string)
  default = {
    "test" = "direct"
  }
}

variable "queue" {
  type = map(map(string))
  default = {
    "test" = {
      "x-queue-type" = "classic"
    }
  }
}

variable "binding" {
  type = map(string)
}