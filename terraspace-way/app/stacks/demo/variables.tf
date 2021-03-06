variable "acl" {
  description = "The canned ACL to apply. Defaults to 'private'."
  type        = string
  default     = "private"
}

variable "env" {
  type        = string
  default     = "draft"
}
