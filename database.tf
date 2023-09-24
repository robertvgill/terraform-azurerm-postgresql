resource "azurerm_postgresql_database" "apgdb" {
  count               = var.psqls_single_create && var.psqls_database_create ? 1 : 0

  name                = var.psqls_single_config.database_name
  resource_group_name = var.rg_resource_group_name
  server_name         = azurerm_postgresql_server.apg[0].name
  charset             = var.psqls_single_config.charset
  collation           = var.psqls_single_config.collation
}

resource "azurerm_postgresql_configuration" "apgdb" {
  for_each            = var.psqls_single_create && var.psqls_database_create != false && var.psqls_single_config != null ? { for k, v in var.psqls_single_config : k => v if v != null } : {}
  name                = each.key
  resource_group_name = var.rg_resource_group_name
  server_name         = azurerm_postgresql_server.apg[0].name
  value               = each.value
}