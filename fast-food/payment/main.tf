variable "payment" {
  type        = map(string)
  description = "Payment strategy"
  validation {
    condition     = contains(["cash", "debit"], var.payment["method"])
    error_message = "Payment method not supported."
  }
  validation {
    condition     = contains(["15", "30"], var.payment["amount"])
    error_message = "Invalid amount entered, plain=15,fried=30."
  }
}


locals {
  price  = {
    15 = 15.00
    30 = 30.00
  }
  method = {
    cash  = "Cash"
    debit = "Debit"
  }
}

output "receipt" {
  value = {
    customer       = var.payment["customer"]
    payment_type   = local.method[var.payment["method"]]
    total_amount   = local.price[var.payment["amount"]]
    receipt_number = base64encode("${var.payment["customer"]} ${var.payment["amount"]}, ${var.payment["method"]}")
  }

}
