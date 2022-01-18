variable "user_name" {
  type    = string
  default = "guest"
}
variable "vhost_name" {
  type    = string
  default = "test"
}

variable "permission" {
  type = map(string)
  default = {
    configure = ".*"
    write     = ".*"
    read      = ".*"
  }
}