# Generated by Terragrunt. Sig: nIlQXj57tbuaRZEa
terraform {
  backend "s3" {
    bucket         = "s3-proyectointegrador-backend-2023"
    dynamodb_table = "dynamodb-table-tahmina-nnanabozho"
    encrypt        = true
    key            = "security_groups/ec2_initial_sg/terraform.tfstate"
    profile        = "aws_iac"
    region         = "us-east-2"
  }
}
