resource "github_repository" "this" {
  name        = "mtc_info_page"
  description = "Repository Information for MTC"
  visibility  = "public"
  auto_init   = true
  pages {
    source {
      branch = "main"
      path   = "/"
    }
  }
  provisioner "local-exec" {
    command = "gh repo view ${self.name} --web"
  }
}

resource "github_repository_file" "this" {
  repository          = github_repository.this.name
  branch              = "main"
  file                = "index.md"
  overwrite_on_create = true
  content = templatefile("${path.module}/templates/index.tftpl", {
    avatar = "https://avatars.githubusercontent.com/u/79756941?v=4",
    name   = "Daniel Sepulvida",
    date   = "2025"
  })
}