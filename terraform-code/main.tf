resource "github_repository" "mtc-repo-1" {
  for_each    = toset(["infra", "backend"])
  name        = "mtc-repo-1-${each.key}"
  description = "${each.value} Code for MTC"
  visibility  = var.env == "dev" ? "private" : "public"
  auto_init   = true
  provisioner "local-exec" {
    command = "gh repo view ${self.name} --web"
  }

  provisioner "local-exec" {
    when    = destroy
    command = "rm -rf ${self.name}"
  }
}

resource "terraform_data" "repo-clone" {
  for_each   = var.repos
  depends_on = [github_repository_file.index, github_repository_file.readme]

  provisioner "local-exec" {
    command = "gh repo clone ${github_repository.mtc-repo-1[each.key].name}"
  }
}

resource "github_repository_file" "readme" {
  for_each            = var.repos
  repository          = github_repository.mtc-repo-1[each.key].name
  branch              = "main"
  file                = "README.md"
  content             = "# This ${var.env} repository is for infra developers"
  overwrite_on_create = true
}

resource "github_repository_file" "index" {
  for_each            = var.repos
  repository          = github_repository.mtc-repo-1[each.key].name
  branch              = "main"
  file                = "index.html"
  content             = "Hello Terraform!"
  overwrite_on_create = true
}

output "clone-urls" {
  value       = { for i in github_repository.mtc-repo-1 : i.name => i.http_clone_url }
  description = "Repository Names and URL"
  sensitive   = false
}