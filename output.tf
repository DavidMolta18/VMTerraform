# Salida con la ID de la Network Interface (NIC)
output "nic_id" {
  value       = azurerm_network_interface.example_nic.id
  description = "ID de la interfaz de red creada"
}

# Salida con la ID de la asociación de seguridad entre la NIC y el NSG
output "nsg_association_id" {
  value       = azurerm_network_interface_security_group_association.example_nic_nsg_assoc.id
  description = "ID de la asociación entre la Network Interface y el NSG"
}
