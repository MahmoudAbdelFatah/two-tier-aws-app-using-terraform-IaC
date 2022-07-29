terraform {
  backend "s3" {
    bucket         = "iti-state-tf"
    key            = "network/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "state-locking-tf"
  }
}
