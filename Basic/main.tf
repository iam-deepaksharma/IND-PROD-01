resource "azurerm_resource_group" "rgblock" {
  name     = "rgbydeepak"
  location = "centralindia"
}

resource "azurerm_storage_account" "storageblock" {
  depends_on               = [azurerm_resource_group.rgblock]
  name                     = "prodstorageind"
  resource_group_name      = azurerm_resource_group.rgblock.name
  location                 = azurerm_resource_group.rgblock.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  queue_properties {
    logging {
      delete                = true
      read                  = true
      write                 = true
      version               = "1.0"
      retention_policy_days = 10
    }
  }
}
resource "azurerm_storage_container" "containerblock" {
  depends_on            = [azurerm_storage_account.storageblock]
  name                  = "remote"
  storage_account_name  = azurerm_storage_account.storageblock.name
  container_access_type = "private"
}
# resource "azurerm_resource_group" "rgblock1" {
#   name     = "rgbydeepak1"
#   location = "centralindia"
# }
