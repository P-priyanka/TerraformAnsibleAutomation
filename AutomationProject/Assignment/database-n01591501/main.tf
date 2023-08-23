resource "azurerm_postgresql_server" "database-server" {
  name                = "pgserver-n01591501"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name            = "GP_Gen5_2"
  storage_mb          = 5120
  backup_retention_days = 7
  geo_redundant_backup_enabled = false
  administrator_login          = "priyanka_n01591501"
  administrator_login_password = "humber@1501"
  ssl_enforcement_enabled      = true  # Enable SSL enforcement
  version                      = "11"  # PostgreSQL version
  tags                         = local.common_tags
}

resource "azurerm_postgresql_database" "n01591501-database" {  
  resource_group_name = var.resource_group_name
  name                = "n01591501-database"
  server_name         = azurerm_postgresql_server.database-server.name
  charset             = "UTF8"
  collation           = "English_United States.1252"
}