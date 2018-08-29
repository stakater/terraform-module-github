# Github User Membership
resource "github_membership" "user" {
  username = "${var.username}"
  role     = "${var.role}"
}

# Github User Team Membership
resource "github_team_membership" "user_team" {
  count = "${var.team_id == "" ? 0 : 1}"
  team_id  = "${var.team_id}"
  username = "${var.username}"
  role     = "${var.role}"
}
