# terraform {
#   backend "local" {
#     path = "../state/terraform.tfstate"
#   }
# }

terraform {
  cloud {

    organization = "Faith83"

    workspaces {
      name = "dev"
    }
  }
}