terraform {
  backend "azurerm" {
  }
}

provider "azurerm" {
  version = "4.37.0"
  # The "feature" block is required for AzureRM provider 2.x.
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "tfstate-rg"
  location = "southindia"
}
