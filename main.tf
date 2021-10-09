# Data lookups
## Organization name
data "tfe_organization" "this_org" {
  name = var.organization
}

## OAuth Token ID
data "tfe_oauth_client" "this_client" {
  oauth_client_id = var.workspace_oauth_id
}

###################################################
# Resources
## Workspace setup
resource "tfe_workspace" "this_ws" {
  name              = var.workspace_name
  organization      = data.tfe_organization.this_org.name
  tag_names         = var.workspace_tags
  terraform_version = (var.workspace_terraform_version == "latest" ? null : var.workspace_terraform_version)
  working_directory = (var.workspace_vcs_directory == "root_directory" ? null : var.workspace_vcs_directory)

  vcs_repo {
    identifier     = var.workspace_vcs_identifier
    branch         = (var.workspace_vcs_branch == "default_branch" ? null : var.workspace_vcs_branch)
    oauth_token_id = data.tfe_oauth_client.this_client.oauth_token_id
  }
}

## Variables
module "variables" {
  source = "./modules/variables"

  for_each     = var.variables
  workspace_id = tfe_workspace.this_ws.id
  key          = each.key
  value        = each.value["value"]
  description  = lookup(each.value, "description", null)
  category     = lookup(each.value, "category", "terraform")
  sensitive    = lookup(each.value, "sensitive", false)
  hcl          = lookup(each.value, "hcl", false)
}

# RBAC
## Teams
### Workspace owner
resource "tfe_team" "this_owners" {
  name         = "${var.workspace_name}-owners"
  organization = data.tfe_organization.this_org.name
}

module "workspace_owner" {
  source = "./modules/rbac_user"

  organization     = data.tfe_organization.this_org.name
  workspace_id     = tfe_workspace.this_ws.id
  team_id          = tfe_team.this_owners.id
  user_email       = var.workspace_owner_email
  user_permissions = "admin"
}

### Read access team
resource "tfe_team" "this_read" {
  name         = "${var.workspace_name}-read"
  organization = data.tfe_organization.this_org.name
}

module "workspace_read" {
  source = "./modules/rbac_user"

  for_each         = toset(var.workspace_read_access_emails)
  organization     = data.tfe_organization.this_org.name
  workspace_id     = tfe_workspace.this_ws.id
  team_id          = tfe_team.this_read.id
  user_email       = each.key
  user_permissions = "read"
}

### Write access team
resource "tfe_team" "this_write" {
  name         = "${var.workspace_name}-write"
  organization = data.tfe_organization.this_org.name
}

module "workspace_write" {
  source = "./modules/rbac_user"

  for_each         = toset(var.workspace_write_access_emails)
  organization     = data.tfe_organization.this_org.name
  workspace_id     = tfe_workspace.this_ws.id
  team_id          = tfe_team.this_write.id
  user_email       = each.key
  user_permissions = "write"
}

### Plan access team
resource "tfe_team" "this_plan" {
  name         = "${var.workspace_name}-plan"
  organization = data.tfe_organization.this_org.name
}

module "workspace_plan" {
  source = "./modules/rbac_user"

  for_each         = toset(var.workspace_plan_access_emails)
  organization     = data.tfe_organization.this_org.name
  workspace_id     = tfe_workspace.this_ws.id
  team_id          = tfe_team.this_plan.id
  user_email       = each.key
  user_permissions = "plan"
}
