# -----------------------
# Medusa values (new)
# -----------------------
variable "database_url" {
  type        = string
  sensitive   = true
}

variable "cookie_secret" {
  type        = string
  sensitive   = true
}

variable "redis_url" {
  type      = string
  default   = ""
  sensitive = true
}

variable "public_backend_url" {
  type    = string
  default = ""
}
