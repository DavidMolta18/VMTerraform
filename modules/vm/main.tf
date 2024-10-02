resource "azurerm_public_ip" "example_public_ip" {
  name                = "example-public-ip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"  # Cambiado de Dynamic a Static
  sku                 = "Standard"  # SKU estándar requiere IP estática
}

resource "azurerm_network_interface" "example_nic" {
  name                = var.nic_name
  location            = var.location
  resource_group_name = var.resource_group_name


  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.example_public_ip.id  # Asociar IP pública
  }
}

resource "azurerm_network_interface_security_group_association" "example_nic_nsg_assoc" {
  network_interface_id      = azurerm_network_interface.example_nic.id
  network_security_group_id = azurerm_network_security_group.example_nsg.id
}

resource "azurerm_network_security_group" "example_nsg" {
  name                = var.nsg_name
  location            = var.location
  resource_group_name = var.resource_group_name

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



resource "azurerm_windows_virtual_machine" "example_vm" {
  name                  = "example-vm"
  resource_group_name   = var.resource_group_name
  location              = var.location
  size                  = "Standard_DS1_v2"
  network_interface_ids = [azurerm_network_interface.example_nic.id]
  admin_username        = var.user
  admin_password        = var.password

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

