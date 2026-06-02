locals {

  env = lower(var.environment)

  resource_group_name = "rg-northflank-${local.env}"

  app_service_plan_name = "asp-northflank-${local.env}"

  webapp_name = "northflank-${local.env}"
}

resource "azurerm_resource_group" "rg" {

  name     = local.resource_group_name
  location = var.location
}

resource "azurerm_service_plan" "plan" {

  name                = local.app_service_plan_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  os_type  = "Linux"
  sku_name = "B1"
}

resource "azurerm_linux_web_app" "webapp" {

  name                = local.webapp_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  service_plan_id = azurerm_service_plan.plan.id

  https_only = true

  site_config {

    application_stack {
      python_version = "3.11"
    }
  }

  app_settings = {
    APP_ENV = upper(local.env)
  }
}
