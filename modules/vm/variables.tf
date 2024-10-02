# Variables para el grupo de recursos
variable "resource_group_name" {
  type        = string
  description = "Nombre del grupo de recursos"
  default     = "example-resourcestf"
}

variable "location" {
  type        = string
  description = "Ubicación de los recursos"
  default     = "West Europe"
}

# Variables para el Network Security Group (NSG)
variable "nsg_name" {
  type        = string
  description = "Nombre del grupo de seguridad de red"
  default     = "example-nsgtf"
}

# Variables para la Network Interface (NIC)
variable "nic_name" {
  type        = string
  description = "Nombre de la interfaz de red"
  default     = "example-nictf"
}

variable "user" {

  type        = string
  description = "Nombre de usuario"
  default     = "distrimolta"
}

variable "password" {
  type        = string
  description = "Contraseña"
  default     = "Hola!123"
}

variable "subnet_id" {

  type        = string
  description = "Subnet id"
}