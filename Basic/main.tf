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
}

resource "azurerm_storage_container" "containerblock" {
  depends_on            = [azurerm_storage_account.storageblock]
  name                  = "remote"
  storage_account_name  = azurerm_storage_account.storageblock.name
  container_access_type = "private"
}
