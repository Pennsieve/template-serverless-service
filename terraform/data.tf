data "aws_caller_identity" "current" {}

data "aws_region" "current_region" {}

# Import Account Data
data "terraform_remote_state" "account" {
  backend = "s3"

  config = {
    bucket = "${var.aws_account}-terraform-state"
    key    = "aws/terraform.tfstate"
    region = "us-east-1"
  }
}

# Import Region Data
data "terraform_remote_state" "region" {
  backend = "s3"

  config = {
    bucket = "${var.aws_account}-terraform-state"
    key    = "aws/${data.aws_region.current_region.name}/terraform.tfstate"
    region = "us-east-1"
  }
}

# Import VPC Data
data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket  = "${var.aws_account}-terraform-state"
    key     = "aws/${data.aws_region.current_region.name}/${var.vpc_name}/terraform.tfstate"
    region  = "us-east-1"
    profile = var.aws_account
  }
}

# Import Platform Infrastructure Data
data "terraform_remote_state" "platform_infrastructure" {
  backend = "s3"

  config = {
    bucket  = "${var.aws_account}-terraform-state"
    key     = "aws/${data.aws_region.current_region.name}/${var.vpc_name}/${var.environment_name}/platform-infrastructure/terraform.tfstate"
    region  = "us-east-1"
    profile = var.aws_account
  }
}

# Import AWS Default SecretsManager KMS Key
data "aws_kms_key" "ssm_kms_key" {
  key_id = "alias/aws/secretsmanager"
}