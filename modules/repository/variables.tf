variable "name" {}

variable "description" {
  default = ""
}

locals {
  default_description = "Development repository for ${var.name}"
  description         = "${var.description == "" ? local.default_description : var.description}"
}


variable "team_id" {
  description = "ID of the team that should own the repo, gives push access"
}

variable "enforce_admins" {
  default = false
}

variable "require_ci_pass" {
  default = true
}

variable "status_checks" {
  type    = "list"
  default = []
}

locals {
  default_status_checks = ["continuous-integration/jenkins/pr-merge"]
  status_checks = ["${split(",", length(var.status_checks) == 0 ? join(",", local.default_status_checks) : join(",", var.status_checks))}"]
}

variable "require_status_checks" {
  default = true
}

variable "has_wiki" {
  default = false
}

variable "has_projects" {
  default = true
}

variable "team_permission" {
  default = "push"
}

# Pull Request Reviews
variable "dismiss_stale_reviews" {
  default = true
}

variable "require_code_owner_reviews" {
  default = true
}

variable "archived" {
  default = false
}

variable "has_downloads" {
  default = true
}

locals {
  default_topics = ["stakater", "chart", "${replace(var.name, "_", "-")}"]
  topics         = "${concat(local.default_topics, var.additional_topics)}"
}

variable "additional_topics" {
  type    = "list"
  default = []
}

variable "private" {
  default = false
}
variable "enable_slack_notifications" {
  default = false
}

variable "slack_webhook_url" {
  default = ""
}

variable "slack_webhook_events" {
  default = []
}

locals {
  default_slack_webhook_events = ["pull_request", "pull_request_review"]
  slack_webhook_events = ["${split(",", length(var.slack_webhook_events) == 0 ? join(",", local.default_slack_webhook_events) : join(",", var.slack_webhook_events))}"]
}
