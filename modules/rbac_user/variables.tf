variable "organization" {
  description = "Name of the organization to find users"
  type        = string
}

variable "team_id" {
  description = "ID of team to add a user to"
  type        = string
}

variable "user_email" {
  description = "Email for the owner of the account"
  type        = string
}

variable "user_permissions" {
  description = "Permission level to grant to user"
  type        = string

  validation {
    condition     = contains(["admin", "read", "plan", "write"], var.user_permissions)
    error_message = "Valid values for user_permissions are admin, read, plan, or write."
  }
}

variable "workspace_id" {
  description = "The ID of the workspace to add access to"
  type        = string
}
