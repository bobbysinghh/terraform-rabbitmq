variable "queue_name" {
  type    = string
  default = "test"
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
  type = map(string)
  default = {

  }

}