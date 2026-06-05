variable "aws_region" {
  type    = string
  default = "us-east-1"
}
variable "environment" {
  type    = string
  default = "staging"
}
variable "github_runner_token" {
  type      = string
  sensitive = true
  default   = ""
}
variable "github_repo_url" {
  type    = string
  default = "https://github.com/mohamedmagdy122"
}
variable "key_name" {
  type    = string
  default = "ecommerce-runners"
}
