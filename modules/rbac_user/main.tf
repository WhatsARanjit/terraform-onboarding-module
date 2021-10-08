data "tfe_organization_membership" "this_membership" {
  organization = var.organization
  email        = var.user_email
}

resource "tfe_team_organization_member" "this_member" {
  team_id                    = var.team_id
  organization_membership_id = data.tfe_organization_membership.this_membership.id
}

resource "tfe_team_access" "this_access" {
  access       = var.user_permissions
  team_id      = var.team_id
  workspace_id = var.workspace_id
}
