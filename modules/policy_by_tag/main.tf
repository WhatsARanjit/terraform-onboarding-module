data "tfe_workspace_ids" "onboarding-apps" {
  tag_names    = var.tags
  organization = var.organization
}

resource "tfe_sentinel_policy" "dummy" {
  name         = "noop"
  description  = "This policy always passes"
  organization = var.organization
  policy       = "main = rule { true }"
  enforce_mode = "hard-mandatory"
}

resource "tfe_policy_set" "onboarding" {
  name          = "onboarding"
  description   = "Applies to workspaces tagged with 'onboarding'"
  organization  = var.organization
  policy_ids    = [tfe_sentinel_policy.dummy.id]
  workspace_ids = values(data.tfe_workspace_ids.onboarding-apps.ids)
}
