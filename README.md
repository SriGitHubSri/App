# App
POC

ariable "access_key" {
  type = string
}

variable "secret_key" {
  type = string
}

provider "aws" {
    access_key = var.access_key
    secret_key = var.secret_key
    region     = "eu-west-1"
    version    = "2.33.0"
}

resource "null_resource" "trigger" {
        triggers = {
        deployment_version = 62 // Increment for each deployment
    }
}


data "aws_caller_identity" "current" {
    depends_on = [
        null_resource.trigger
    ]
}

output "account_number" {
    value = data.aws_caller_identity.current.account_id
}
