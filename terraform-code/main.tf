resource "github_repository" "mtc-repo-1" {
  for_each    = toset(["infra", "backend"])
  name        = "mtc-repo-1-${each.key}"
  description = "${each.value} Code for MTC"
  visibility  = var.env == "dev" ? "private" : "public"
  auto_init   = true
}

resource "github_repository_file" "readme" {
  for_each   = var.repos
  repository = github_repository.mtc-repo-1[each.key].name
  branch     = "main"
  file       = "README.md"
  content    = "# This ${var.env} repository is for infra developers"
}

resource "github_repository_file" "index" {
  for_each            = var.repos
  repository          = github_repository.mtc-repo-1[each.key].name
  branch              = main
  file                = "index.html"
  content             = "Hello Terraform!"
  overwrite_on_create = true
}

output "clone-urls" {
  value       = { for i in github_repository.mtc-repo-1 : i.name => i.http_clone_url }
  description = "Repository Names and URL"
  sensitive   = false
}