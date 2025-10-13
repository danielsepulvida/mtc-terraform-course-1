output "clone-urls" {
  value = { for i in github_repository.mtc-repo-1 : i.name => {
    ssh-clone-url  = i.ssh_clone_url,
    http-clone-url = i.http_clone_url,
    pages-url      = i.pages[0].html_url
    }
  }
  description = "Repository Names and URL"
  sensitive   = false
}