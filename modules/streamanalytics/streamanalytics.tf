resource "azurerm_stream_analytics_cluster" "btb_stream_analytics_cluster" {
  name                = var.stream_analytics_name
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  streaming_capacity  = 36
}