terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.114.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "ac30d9b8-34e5-4948-80d1-d9c571735ea3"
}

resource "azurerm_resource_group" "block3" {
  name     = "rg-lab"
  location = "centralindia"
}

resource "azurerm_storage_account" "block4" {
  depends_on               = [azurerm_resource_group.block3]
  name                     = "prodstorageind"
  resource_group_name      = azurerm_resource_group.block3.name
  location                 = azurerm_resource_group.block3.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
