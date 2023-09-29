variable "tags" { default = {} }
variable "topic_bucket" {
  description = "ID of s3 bucket with data from kafka topic"
}
variable "availability_zone" {}
variable "security_groups" {}
variable "client_subnets" {}
variable "bootstrap_servers" {}