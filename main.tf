{# Definición del provider
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

# Network Security Group (NSG) con reglas de SSH y RDP
resource "azurerm_network_security_group" "example_nsg" {
  name                = var.nsg_name
  location            = azurerm_resource_group.example_rg.location
  resource_group_name = azurerm_resource_group.example_rg.name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "RDP"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# Interfaz de Red (Network Interface)
resource "azurerm_network_interface" "example_nic" {
  name                = var.nic_name
  location            = azurerm_resource_group.example_rg.location
  resource_group_name = azurerm_resource_group.example_rg.name


  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.example_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.example_public_ip.id  # Asociar IP pública
  }
}

# Asociación entre Network Interface y NSG
resource "azurerm_network_interface_security_group_association" "example_nic_nsg_assoc" {
  network_interface_id      = azurerm_network_interface.example_nic.id
  network_security_group_id = azurerm_network_security_group.example_nsg.id
}

# Crear una dirección IP pública
resource "azurerm_public_ip" "example_public_ip" {
  name                = "example-public-ip"
  location            = azurerm_resource_group.example_rg.location
  resource_group_name = azurerm_resource_group.example_rg.name
  allocation_method   = "Static"  # Cambiado de Dynamic a Static
  sku                 = "Standard"  # SKU estándar requiere IP estática
}

# Crear una máquina virtual Windows con RDP
resource "azurerm_windows_virtual_machine" "example_vm" {
  name                  = "example-vm"
  resource_group_name   = azurerm_resource_group.example_rg.name
  location              = azurerm_resource_group.example_rg.location
  size                  = "Standard_DS1_v2"
  network_interface_ids = [azurerm_network_interface.example_nic.id]
  admin_username        = "distrimolta"
  admin_password        = "Hola!123"  # Cambia esta contraseña

  os_disk { 
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
}
}