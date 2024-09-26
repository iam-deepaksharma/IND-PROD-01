resource "azurerm_virtual_network" "vnetblock" {
  name                = "vnet-prod"
  resource_group_name = azurerm_resource_group.rgblock.name
  location            = azurerm_resource_group.rgblock.location
  address_space       = ["10.1.0.0/24"]
}

resource "azurerm_subnet" "subnetblock" {
    depends_on = [ azurerm_virtual_network.vnetblock ]
  name                 = "subnet-prod"
  resource_group_name  = azurerm_resource_group.rgblock.name
  virtual_network_name = azurerm_virtual_network.vnetblock.name
  address_prefixes     = ["10.1.0.0/26"]
}

resource "azurerm_public_ip" "pipblock" {
  name                = "publicip"
  resource_group_name = azurerm_resource_group.rgblock.name
  location            = azurerm_resource_group.rgblock.location
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "nicblock" {
  name                = "prod-nic"
  resource_group_name = azurerm_resource_group.rgblock.name
  location            = azurerm_resource_group.rgblock.location

  ip_configuration {
    name                          = "prodip"
    subnet_id                     = azurerm_subnet.subnetblock.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pipblock.id
  }
}

resource "azurerm_linux_virtual_machine" "vmblock" {
    depends_on = [ azurerm_resource_group.rgblock, azurerm_subnet.subnetblock ]
  name                  = "fevm1"
  resource_group_name   = azurerm_resource_group.rgblock.name
  location              = azurerm_resource_group.rgblock.location
  size                  = "Standard_DS1_v2"
  admin_username        = "azureuser"
  admin_password        = "Tulsaking@123"
  disable_password_authentication = false
  network_interface_ids = [azurerm_network_interface.nicblock.id]
    # admin_ssh_key {
      
    # }
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}
