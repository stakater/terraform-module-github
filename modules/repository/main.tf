resource "github_repository" "repository" {
  name = "${var.name}"
  description  = "${local.description}"
  
  private = "${var.private}"
  has_issues = true
  has_wiki = "${var.has_wiki}"
  has_projects = "${var.has_projects}"
  allow_merge_commit = true
  allow_squash_merge = true
  allow_rebase_merge = true
  has_downloads = "${var.has_downloads}"
  auto_init = true
  archived = "${var.archived}"
  topics = "${local.topics}"
}

resource "github_branch_protection" "repository_master_with_status_checks" {
  count = "${var.enable_branch_protection && var.require_status_checks ? 1 : 0}"
  repository = "${var.name}"
  branch = "${var.protected_branch_name}"
  enforce_admins = "${var.enforce_admins}"

  required_status_checks {
    strict = "${var.require_ci_pass}"
    contexts = ["${local.status_checks}"]
  }

  required_pull_request_reviews {
    dismiss_stale_reviews = "${var.dismiss_stale_reviews}"
    require_code_owner_reviews = "${var.require_code_owner_reviews}"
  }

  depends_on = ["github_repository.repository"]
}

resource "github_branch_protection" "repository_master" {
  count = "${var.enable_branch_protection && !var.require_status_checks ? 1 : 0}"
  repository = "${var.name}"
  branch = "${var.protected_branch_name}"
  enforce_admins = "${var.enforce_admins}"

  required_pull_request_reviews {
    dismiss_stale_reviews = "${var.dismiss_stale_reviews}"
    require_code_owner_reviews = "${var.require_code_owner_reviews}"
  }

  depends_on = ["github_repository.repository"]
}

resource "github_repository_webhook" "slack_webhook" {
  count = "${var.enable_slack_notifications}"
  repository = "${var.name}"
  name = "web"

  configuration {
    url          = "${var.slack_webhook_url}"
    content_type = "json"
    insecure_ssl = false
  }

  active = true

  events = ["${local.slack_webhook_events}"]

  depends_on = ["github_repository.repository"]
}

resource "github_team_repository" "restricted_access" {
  count = "${length(var.team_id) != 0 ? 1 : 0}"
  team_id = "${var.team_id}"
  repository = "${github_repository.repository.name}"
  permission = "${var.team_permission}"
}