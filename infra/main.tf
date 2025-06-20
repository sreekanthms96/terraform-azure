provider "azurerm" {
  features {}
}

# Create a Resource Group
resource "azurerm_resource_group" "resource_group" {
  name     = "rg-terraform-demo"
  location = "eastus"
}

# Create a storage account
resource "azurerm_storage_account" "storage_account" {
  name                     = "terraformindia1"
  resource_group_name      = azurerm_resource_group.resource_group.name
  location                 = azurerm_resource_group.resource_group.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"

  static_website {
    index_document = "index.html"
  }
}

# Add an index.html file
resource "azurerm_storage_blob" "blob" {
  name                   = "index.html"
  storage_account_name   = azurerm_storage_account.storage_account.name
  storage_container_name = "$web"
  type                   = "Block"
  content_type           = "text/html"
  source_content         = "<h1>Test website working, and deployed using Terraform</h1>"
}
