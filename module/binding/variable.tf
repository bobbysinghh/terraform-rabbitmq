variable "source_name" {
  type    = string
  default = "test"

}
variable "destination" {
  type    = string
  default = "test"
}

variable "destination_type" {
  type    = string
  default = "queue"

}

variable "vhost_name" {
  type    = string
  default = "test"
}

variable "routing_key" {
  type    = string
  default = "#"

}
variable "arguments" {
  type    = map(string)
  default = {}

}