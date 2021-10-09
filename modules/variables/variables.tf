variable "workspace_id" {
  description = "The ID of the workspace to add access to"
  type        = string
}

variable "key" {
  description = "Name of the variable"
  type        = string
}

variable "value" {
  description = "Value of the variable"
  type        = string
}

variable "description" {
  description = "Variable description"
  type        = string
  default     = ""
}

variable "category" {
  description = "TF or environment variable"
  type        = string

  validation {
    condition     = contains(["terraform", "env"], var.category)
    error_message = "Valid values for user_permissions are terraform or env."
  }
}

variable "sensitive" {
  description = "Whether to hide variable from view"
  type        = bool
  default     = false
}

variable "hcl" {
  description = "If variable should be parsed as HCL"
  type        = bool
  default     = false
}
