variable "customer" {
  type        = string
  description = "The customer name"
}

variable "amount" {
  type = number
  description = "The order amount paid"
}

variable "rice" {
  type        = string
  description = "Rice to offer"
  default     = "fried"
  validation {
    condition     = contains(["plain", "fried"], var.rice)
    error_message = "The rice must be in the list, plain,fried."
  }
}

variable "meat" {
  type    = string
  default = "chicken"
  validation {
    condition     = contains(["chicken", "beef", "fish"], var.meat)
    error_message = "The meat must be in the list, chicken,beef,fish."
  }
}

locals {
  result = {
    customer = "${var.customer} your order is ready"
    order     = {
      rice = var.rice
      meat = var.meat
    }
  }
}

output "order-item" {
  value = local.result
}
