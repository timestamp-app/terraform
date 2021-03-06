resource "azurerm_storage_account" "this" {
  name                     = local.name
  resource_group_name      = azurerm_resource_group.this.name
  location                 = azurerm_resource_group.this.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_table" "records" {
  name                 = "records"
  storage_account_name = azurerm_storage_account.this.name
}
