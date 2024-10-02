# Definición del provider
provider "azurerm" {
  features {}

  subscription_id = var.subscription_id
}

# Grupo de recursos
resource "azurerm_resource_group" "example_rg" {
  name     = var.resource_group_name
  location = var.location
}

# Red virtual
resource "azurerm_virtual_network" "example_vnet" {
  name                = var.vnet_name
  address_space       = [var.vnet_address_space]
  location            = azurerm_resource_group.example_rg.location
  resource_group_name = azurerm_resource_group.example_rg.name
}

# Subred
resource "azurerm_subnet" "example_subnet" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.example_rg.name
  virtual_network_name = azurerm_virtual_network.example_vnet.name
  address_prefixes     = [var.subnet_address_prefix]
}

module "vm" {

  source              = "./modules/vm"
  resource_group_name = azurerm_resource_group.example_rg.name
  location            = azurerm_resource_group.example_rg.location
  subnet_id           = azurerm_subnet.example_subnet.id
  user                = var.user
  password            = var.password
}
