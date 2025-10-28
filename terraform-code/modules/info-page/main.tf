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
    command = var.run_provisioners ? "gh repo view ${self.name} --web" : "echo 'skip repo view'"
  }
}

data "github_user" "current" {
  username = ""
}

resource "time_static" "this" {}

resource "github_repository_file" "this" {
  repository          = github_repository.this.name
  branch              = "main"
  file                = "index.md"
  overwrite_on_create = true
  content = templatefile("${path.module}/templates/index.tftpl", {
    #    avatar = "https://cdn.jsdelivr.net/gh/alohe/avatars/png/vibrent_6.png",# data.github_user.current.avatar_url,
    avatar = data.github_user.current.avatar_url, #"https://avatars.githubusercontent.com/u/23561793?v=4",# data.github_user.current.avatar_url,
    name   = data.github_user.current.name,
    date   = time_static.this.year
    repos  = var.repos
  })
}
