variable "customer" {
  type        = string
  description = "The Customer name"
}

variable "payment-type" {
  type        = string
  description = "Payment type"
}

variable "payment-amount" {
  type        = number
  description = "Payment amount"
}

variable "order" {
  type        = map(string)
  default     = {
    "rice" = "fried",
    "meat" = "chicken"
  }
  description = "The customer order"
}

module "fast-food" {
  source   = "./food"
  customer = var.customer
  amount   = var.payment-amount
  rice     = var.order["rice"]
  meat     = var.order["meat"]
}

module "payment" {
  source  = "./payment"
  payment = {
    customer = var.customer
    amount   = var.payment-amount
    method   = var.payment-type
  }
}

output "order-complete" {
  value = {
    order = module.fast-food
    receipt = module.payment
  }
}
