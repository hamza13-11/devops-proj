# backend.tf
terraform {
  backend "s3" {
    bucket         = "hamza-statebucket"
    key            = "terraform/state.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "hamza-locktable"
  }
}
