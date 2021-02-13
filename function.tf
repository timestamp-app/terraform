resource "azurerm_app_service_plan" "this" {
  name                = local.name
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  kind                = "FunctionApp"

  sku {
    tier = "Dynamic"
    size = "Y1"
  }
}

resource "azurerm_application_insights" "this" {
  name                = local.name
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  application_type    = "other"
}

resource "azurerm_function_app" "this" {
  name                       = local.name
  location                   = azurerm_resource_group.this.location
  resource_group_name        = azurerm_resource_group.this.name
  app_service_plan_id        = azurerm_app_service_plan.this.id
  storage_account_name       = azurerm_storage_account.this.name
  storage_account_access_key = azurerm_storage_account.this.primary_access_key
  https_only                 = true
  version                    = "~3"
  app_settings = {
    "FUNCTIONS_WORKER_RUNTIME"       = "node",
    "WEBSITE_NODE_DEFAULT_VERSION"   = "~12",
    "APPINSIGHTS_INSTRUMENTATIONKEY" = azurerm_application_insights.this.instrumentation_key,
    "WEBSITE_RUN_FROM_PACKAGE"       = "1",
    "WIREPUSHER_ID"                  = var.wirepusher_id
  }
}
