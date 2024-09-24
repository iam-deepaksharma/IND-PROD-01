terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.114.0"
    }
  }
  backend "azurerm" {
    resource_group_name   = "rg-lab"
    storage_account_name  = "prodstorageind"
    container_name        = "remote"
    key                   = "terraform.tfstate"
  }
  # backend "local" {
  #   path = "./terraform.tfstate"
  # }
}

provider "azurerm" {
  features {}
  subscription_id = "ac30d9b8-34e5-4948-80d1-d9c571735ea3"
}

resource "azurerm_resource_group" "rgblock" {
  name     = "rg-lab"
  location = "centralindia"
}

resource "azurerm_storage_account" "storageblock" {
  depends_on               = [azurerm_resource_group.rgblock]
  name                     = "prodstorageind"
  resource_group_name      = azurerm_resource_group.rgblock.name
  location                 = azurerm_resource_group.rgblock.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "containerblock" {
  depends_on            = [azurerm_storage_account.storageblock]
  name                  = "remote"
  storage_account_name  = azurerm_storage_account.storageblock.name
  container_access_type = "private"
}
