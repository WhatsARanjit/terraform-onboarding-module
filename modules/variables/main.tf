resource "tfe_variable" "this_variable" {
  key          = var.key
  value        = var.value
  category     = var.category
  workspace_id = var.workspace_id
  description  = var.description
  sensitive    = var.sensitive
  hcl          = var.hcl
}
