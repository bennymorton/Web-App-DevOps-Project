# /aks-terraform/networking-module/variables

variable "location" {
  description = "Location of Azure subscription"
  type        = string
  default     = "UK South"
}
variable "vnet_address_space" {
  description = "Vnet address space"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}