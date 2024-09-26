terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.114.0"
    }
  }
  # backend "azurerm" {
  #   resource_group_name   = "rg-lab"
  #   storage_account_name  = "prodstorageind"
  #   container_name        = "remote"
  #   key                   = "terraform.tfstate"
  # }
  backend "local" {
    path = "./terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
  subscription_id = "ac30d9b8-34e5-4948-80d1-d9c571735ea3"
}