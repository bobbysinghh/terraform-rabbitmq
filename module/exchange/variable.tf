variable "exchange_name" {
  type    = string
  default = "test"
}

variable "exchange_type" {
  type    = string
  default = "direct"

}

variable "auto_delete" {
  type    = bool
  default = false

}

variable "durable" {
  type    = bool
  default = true

}

variable "vhost_name" {
  type    = string
  default = "test"
}

variable "arguments" {
  type    = map(string)
  default = {}

}
