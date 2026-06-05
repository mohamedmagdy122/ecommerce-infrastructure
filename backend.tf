terraform {
  backend "s3" {
    bucket         = "my-terraform-state-bucket-magdy"
    key            = "ecommerce/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
  }
}
