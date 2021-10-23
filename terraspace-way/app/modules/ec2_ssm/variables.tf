variable "env" {
  description = "The name of the Environment"
  type        = string
  default     = "draft"
}

variable "region" {
  description = "Aws region"
  type        = string
  default     = "us-east-1"
}

variable "vpc_id" {
  type        = string
  default     = ""
}

variable "subnet_id" {
  type        = string
  default     = ""
}
