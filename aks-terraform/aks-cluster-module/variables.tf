# aks-terraform/aks-cluster module input variables
variable "aks_cluster_name" {
  description = "AKS cluster name"
  type        = string
}

variable "cluster_location" {
  description = "AKS cluster location"
  type        = string
  default     = "UK South"
}
variable "managed_identity_id" {
  type        = string
}

# Output variables from the networking module
variable "networking_resource_group_name" {
  description = "Networking resource group name"
  type        = string
}
variable "vnet_id" {
  description = "VNet ID"
  type        = string
}
variable "control_plane_subnet_id" {
  description = "Control plan subnet ID"
  type        = string
}
variable "worker_node_subnet_id" {
  description = "Worker node subnet ID"
  type        = string
}
variable "aks_nsg_id" {
  description = "AKS NSG ID"
  type        = string
}
variable "dns_prefix" {
  description = "DNS Prefix"
  type        = string
  default     = "devops-project-aks-cluster"
}