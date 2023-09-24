resource "azurerm_postgresql_firewall_rule" "apgfw" {
  for_each            = var.psqls_single_create != false && var.psqls_firewall_rules != null ? { for k, v in var.psqls_firewall_rules : k => v if v != null } : {}
  name                = format("%s", each.key)

  resource_group_name = var.rg_resource_group_name
  server_name         = var.psqls_single_create ? azurerm_postgresql_server.apg[0].name : null

  start_ip_address    = each.value["start_ip_address"]
  end_ip_address      = each.value["end_ip_address"]
}