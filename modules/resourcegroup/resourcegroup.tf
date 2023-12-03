resource "azurerm_resource_group" "btb_resource_group" {
  name = var.resource_group_name
  location = "West Europe"
}