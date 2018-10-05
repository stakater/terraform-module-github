variable "name" {}

variable "description" {
  default = ""
}

locals {
  default_description = "Development repository for ${var.name}"
  description         = "${var.description == "" ? local.default_description : var.description}"
}


variable "homepage_url" {
  default = "http://stakater.com"
}

variable "license_template" {
  default = ""
}

locals {
  license_template = "${var.private == "false" ? "apache-2.0" : ""}"
}


variable "team_id" {
  description = "ID of the team that should own the repo, gives push access"
  default = ""
}

variable "enable_branch_protection" {
  default = true
}

variable "protected_branch_name" {
  default = "master"
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
  topics = ["${compact(split(",", lower(replace(join(",", var.topics), "/\\s|_|\\./", "-"))))}"]
}

variable "topics" {
  type    = "list"
  default = []
}

variable "private" {
  default = false
}

variable "webhooks" {
  type = "list"
  default = []
}
