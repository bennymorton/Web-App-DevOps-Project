locals {
  unique_uuid         = "778b63be"
  resource_group_name = "778b63be-terraform-rg"
}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.95.0"
    }
  }
}

provider "azurerm" {
  features {}
  skip_provider_registration = true
  client_id                  = var.client_id
  client_secret              = var.client_secret
  subscription_id            = var.subscription_id
  tenant_id                  = var.tenant_id
}


module "networking" {
  source = "./networking-module"

  # Input variables for the networking module
  location           = "UK South"
  vnet_address_space = ["10.0.0.0/16"]
  #   resource_group_name = local.resource_group_name

}

module "aks_cluster" {
  source = "./aks-cluster-module"

  # Input variables for the AKS cluster module
  aks_cluster_name    = "${local.unique_uuid}-aks-cluster"
  cluster_location    = var.cluster_location
  managed_identity_id = var.managed_identity_id
  networking_resource_group_name = local.resource_group_name

  # Input variables referencing outputs from the networking module
  vnet_id                        = module.networking.vnet_id
  control_plane_subnet_id        = module.networking.control_plane_subnet_id
  worker_node_subnet_id          = module.networking.worker_node_subnet_id
  aks_nsg_id                     = module.networking.aks_nsg_id

  # Define more input variables as needed...
}