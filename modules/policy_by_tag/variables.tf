variable "organization" {
  description = "TFC Organization to build under"
  type        = string
}

variable "tags" {
  description = "Tags to search for to attach policy"
  type        = list
  default     = ["onboarding"]
}
