#added a comment


resource "azurerm_resource_group" "RG-Terraform" {
  name     = "test-rg"
  location = "south india"
}

 resource "azurerm_management_lock" "rg_lock" {
 name       = "anti-delete"
  scope      = azurerm_resource_group.RG-Terraform.id
  lock_level = "CanNotDelete" // or "ReadOnly"
  notes      = "This lock prevents accidental deletion of the resource group."
}

 resource "azurerm_storage_account" "blob" {
  name                     = "storagerenamed"
  resource_group_name      = azurerm_resource_group.RG-Terraform.name
  location                 = azurerm_resource_group.RG-Terraform.location
  account_tier             = "Standard"
  account_replication_type = "LRS" 

  blob_properties {
    delete_retention_policy {
      days = 111
    }

       container_delete_retention_policy {
      days = 111 // Retain deleted containers for 111 days
    }
  } 
  }

