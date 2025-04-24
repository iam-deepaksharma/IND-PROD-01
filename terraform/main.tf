resource "azurerm_resource_group" "rgblock" {
  name     = "prod-rg"
  location = "centralindia"
}

resource "azurerm_resource_group" "rgblock1" {
  name     = "prod-rg1"
  location = "centralindia"
}

resource "azurerm_storage_account" "storageblock" {
    depends_on = [ azurerm_resource_group.rgblock ]
  name                     = "trendulkarstorage"
  resource_group_name      = azurerm_resource_group.rgblock.name
  location                 = azurerm_resource_group.rgblock.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "containerblock" {
    depends_on = [ azurerm_storage_account.storageblock ]
  name                  = "prodcontainer"
  storage_account_name  = azurerm_storage_account.storageblock.name
  container_access_type = "private"
}

resource "azurerm_storage_blob" "blobblock" {
    depends_on = [ azurerm_storage_container.containerblock ]
  name                   = "prodblob"
  storage_account_name   = azurerm_storage_account.storageblock.name
  storage_container_name = azurerm_storage_container.containerblock.name
  type                   = "Block"
  source                 = "C:/Users/Lenovo/Desktop/DevOps/IND-PROD-01/terraform/sample.txt"
}