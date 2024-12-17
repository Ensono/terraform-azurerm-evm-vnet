provider "azurerm" {
  subscription_id     = var.azure_subscription_id
  storage_use_azuread = true

  features {}
}
