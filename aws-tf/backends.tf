terraform {
  backend "s3" {
    bucket       = "faithsk-tf-state"
    key          = "backend/mtc/terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true
  }
}
