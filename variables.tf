# Variable para la suscripción
variable "subscription_id" {
  type        = string
  description = "ID de la suscripción de Azure"
  default     = "b3634f9b-63e3-4721-b11f-7606ff73dd57" # Cámbialo si es necesario
}

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

# Variables para la red virtual (VNet)
variable "vnet_name" {
  type        = string
  description = "Nombre de la red virtual"
  default     = "example-vnettf"
}

variable "vnet_address_space" {
  type        = string
  description = "Espacio de direcciones de la red virtual"
  default     = "10.0.0.0/16"
}

# Variables para la subred
variable "subnet_name" {
  type        = string
  description = "Nombre de la subred"
  default     = "internaltf"
}

variable "subnet_address_prefix" {
  type        = string
  description = "Prefijo de direcciones de la subred"
  default     = "10.0.2.0/24"
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
