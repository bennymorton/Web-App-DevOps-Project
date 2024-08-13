locals {
    unique_uuid = "778b63be"
    resource_group_name = "778b63be-terraform-rg"  # Replace with your actual resource group name
}
# resource "azurerm_resource_group" "networking_rg" {
#   name     = local.resource_group_name
#   location = "UK South"
# }
resource "azurerm_virtual_network" "aks_vnet" {
  name                = "${local.unique_uuid}-vnet"
  address_space       = var.vnet_address_space
  location            = var.location
  resource_group_name = local.resource_group_name
}

resource "azurerm_subnet" "control_plane_subnet" {
  name                 = "${local.unique_uuid}-subnet1"
  resource_group_name  = local.resource_group_name
  virtual_network_name = azurerm_virtual_network.aks_vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}
resource "azurerm_subnet" "worker_node_subnet" {
  name                 = "${local.unique_uuid}-subnet2"
  resource_group_name  = local.resource_group_name
  virtual_network_name = azurerm_virtual_network.aks_vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}
resource "azurerm_network_security_group" "aks_nsg" {
  name                = "${local.unique_uuid}-security-group"
  location            = var.location
  resource_group_name = local.resource_group_name
}
resource "azurerm_network_security_rule" "kube-apiserver-rule" {
  name                        = "${local.unique_uuid}-security-rule1"
  resource_group_name         = local.resource_group_name
  network_security_group_name = azurerm_network_security_group.aks_nsg.name
  priority                    = 1001
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
}
resource "azurerm_network_security_rule" "ssh-rule" {
  name                        = "${local.unique_uuid}-security-rule2"
  resource_group_name         = local.resource_group_name
  network_security_group_name = azurerm_network_security_group.aks_nsg.name
  priority                    = 1002
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
}