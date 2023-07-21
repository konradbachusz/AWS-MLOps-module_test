# https://terratest.gruntwork.io/docs/getting-started/quick-start/ - example test for terratest
terraform {
  required_version = ">= 0.12.26"
}

# The simplest possible Terraform module: it just outputs "Hello, World!"
output "hello_world" {
  value = "Hello, World!"
}