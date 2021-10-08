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

## Required TF/Env variables
variable "bu" {
  description = "Business unit ID"
  type = string
}

variable "default_tags" {
  description = "Tags to apply by default to VMs"
  type        = string
  default     = "{ \"environment\"= \"test\", \"owner\"= \"WhatsARanjit\" }"
}

## Optional variables
variable "tf_variables" {
  description = "Additional Terraform variables"
  type        = map
  default     = {}
}

variable "env_variables" {
  description = "Additional environment variables"
  type        = map
  default     = {}
}

## Optional sensitive variables
variable "sensitive_tf_variables" {
  description = "Additional sensitive Terraform variables"
  type        = map
  default     = {}
}

variable "sensitive_env_variables" {
  description = "Additional sensitive environment variables"
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
