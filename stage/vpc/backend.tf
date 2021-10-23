terraform {
  backend "s3" {
    bucket = "770034418984-terraform-state"
    key = "stage/vpc/terraform.tfstate"
    region = "eu-west-2"
    dynamodb_table = "770034418984-terraform-locks"
    encrypt = true
  }
}
