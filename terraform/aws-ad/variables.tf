variable "domainName" {
  default = "domain.lan"
}

variable "domainPassword" {
  default = "password"
}

variable "vpc_tags" {
  type    = "map"
  default = {}
}

variable "subnet_tags" {
  type    = "list"
  default = []
}

variable "tags" {
  type    = "map"
  default = {}
}
