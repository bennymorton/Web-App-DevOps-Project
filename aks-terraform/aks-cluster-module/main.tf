# aks-cluster/main.tf
# Create the AKS cluster
locals {
    unique_uuid = "778b63be"
    resource_group_name = "778b63be-terraform-rg"
}

resource "azurerm_kubernetes_cluster" "aks_cluster" {
  name                = "${local.unique_uuid}-aks-cluster"
  location            = var.cluster_location
  resource_group_name = local.resource_group_name
  dns_prefix          = var.dns_prefix

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_DS2_v2"
    enable_auto_scaling = true
    min_count = 1
    max_count = 2
  }
  identity {
    type = "UserAssigned"
    identity_ids = [
        var.managed_identity_id
    ]
  }
}