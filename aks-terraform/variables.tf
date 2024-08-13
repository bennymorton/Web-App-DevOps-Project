variable "client_id" {
  description = "Access key for the provider"
  type        = string
  sensitive   = true
}

variable "client_secret" {
  description = "Secret key for the provider"
  type        = string
  sensitive   = true
}

variable "subscription_id" {
  description = "Azure subscription ID"
  type        = string
}

variable "tenant_id" {
  description = "Azure tenant ID"
  type        = string
}

variable "cluster_location" {
  description = "AKS cluster location"
  type        = string
  default     = "UK South"
}

variable "vnet_address_space" {
  description = "Vnet address space"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "managed_identity_id" {
  description = "Azure Managed Identity ID"
  type        = string
}
