terraform {
  backend "s3" {
    key          = "lab2/bai1/terraform.tfstate"
    region       = "ap-southeast-1"
    encrypt      = true
    use_lockfile = true
  }
}