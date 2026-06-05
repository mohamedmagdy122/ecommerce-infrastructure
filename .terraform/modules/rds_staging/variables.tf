variable "name" {
  type = string
}
variable "environment" {
  type = string
}
variable "vpc_id" {
  type = string
}
variable "private_subnet_ids" {
  type = list(string)
}
variable "db_name" {
  type    = string
  default = "ecommerce"
}
variable "db_username" {
  type    = string
  default = "admin"
}
variable "db_password" {
  type      = string
  sensitive = true
}
variable "instance_class" {
  type    = string
  default = "db.t3.micro"
}
variable "allowed_cidr_blocks" {
  type = list(string)
}
