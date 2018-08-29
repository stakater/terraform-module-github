resource "github_issue_label" "first_issue" {
  repository = "${github_repository.repository.name}"
  name       = "good first issue"
  color      = "8570ff"
}

resource "github_issue_label" "kind_bug" {
  repository = "${github_repository.repository.name}"
  name       = "kind / bug"
  color      = "c84b58"
}

resource "github_issue_label" "kind_documentation" {
  repository = "${github_repository.repository.name}"
  name       = "kind / documentation"
  color      = "fbd22a"
}

resource "github_issue_label" "kind_enhancement" {
  repository = "${github_repository.repository.name}"
  name       = "kind / enhancement"
  color      = "b0f0f1"
}

resource "github_issue_label" "kind_help_wanted" {
  repository = "${github_repository.repository.name}"
  name       = "kind / help wanted"
  color      = "269887"
}

resource "github_issue_label" "kind_quesstion" {
  repository = "${github_repository.repository.name}"
  name       = "kind / question"
  color      = "dd8ae7"
}

resource "github_issue_label" "workflow_done" {
  repository = "${github_repository.repository.name}"
  name       = "workflow / done"
  color      = "266cd3"
}

resource "github_issue_label" "workflow_in_progress" {
  repository = "${github_repository.repository.name}"
  name       = "workflow / in progress"
  color      = "266cd3"
}

resource "github_issue_label" "workflow_invalid" {
  repository = "${github_repository.repository.name}"
  name       = "workflow / invalid"
  color      = "266cd3"
}

resource "github_issue_label" "workflow_todo" {
  repository = "${github_repository.repository.name}"
  name       = "workflow / todo"
  color      = "266cd3"
}

resource "github_issue_label" "workflow_wont_fix" {
  repository = "${github_repository.repository.name}"
  name       = "workflow / wont fix"
  color      = "266cd3"
}