variable "subscription_id" {
  type = string
}

variable "location" {
  type    = string
  default = "East US"
}

variable "environment" {
  description = "Environment Name"
  type        = string

  validation {
    condition     = contains(["dev", "uat", "prod"], lower(var.environment))
    error_message = "Environment must be dev, uat or prod."
  }
}
