# Organization level variables
variable "organization" {
  description = "TFC Organization to build under"
  type        = string
}

# Workspace level variables
variable "workspace_name" {
  description = "Name of the workspace to create"
  type        = string
}

variable "workspace_description" {
  description = "Description of workspace"
  type        = string
  default     = ""
}

variable "workspace_terraform_version" {
  description = "Version of Terraform to run"
  type        = string
  default     = "latest"
}

variable "workspace_tags" {
  description = "Tags to apply to workspace"
  type       = list(string)
  default    = []
}

## VCS variables (existing VCS connection)
variable "workspace_vcs_identifier" {
  description = "<organization>/<repository> address of repo"
  type        = string
}

variable "workspace_vcs_branch" {
  description = "VCS branch to use"
  type        = string
  default     = "default_branch"
}

variable "workspace_vcs_directory" {
  description = "Working directory to use in repo"
  type        = string
  default     = "root_directory"
}

variable "workspace_oauth_id" {
  description = "OAuth ID from VCS connection"
  type        = string
  sensitive   = true
}

# Variables
variable "variables" {
  description = "Map of all variables for workspace"
  type        = map
  default     = {}
}

# RBAC
## Workspace owner (exising org user)
variable "workspace_owner_email" {
  description = "Email for the owner of the account"
  type        = string
}

## Additional read users (existing org user)
variable "workspace_read_access_emails" {
  description = "Emails for the read users"
  type        = list(string)
  default     = []
}

## Additional write users (existing org user)
variable "workspace_write_access_emails" {
  description = "Emails for the write users"
  type        = list(string)
  default     = []
}

## Additional plan users (existing org user)
variable "workspace_plan_access_emails" {
  description = "Emails for the plan users"
  type        = list(string)
  default     = []
}
