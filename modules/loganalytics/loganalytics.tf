resource "azurerm_log_analytics_cluster" "btb_log_analytics_cluster" {
  name                = var.log_analytics_name
  resource_group_name =var.resource_group_name
  location            = var.resource_group_location

  identity {
    type = "SystemAssigned"
  }
}