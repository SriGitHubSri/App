terraform {
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "2.4.1"
    }
  }
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

resource "helm_release" "nginx" {
  name      = "my-nginx-release"
  chart     = "../my-nginx-chart" # Adjust the path to where your chart is located relative to this Terraform configuration
  namespace = "default"
  values = [
    file("../my-nginx-chart/values.yaml")
  ]
}

