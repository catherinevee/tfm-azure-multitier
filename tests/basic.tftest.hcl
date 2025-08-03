# Basic test for Azure Multi-Tier Architecture module
# This test validates the basic functionality of the module

run "basic_deployment" {
  command = plan

  variables {
    resource_group_name = "test-rg-multitier"
    location           = "eastus"
  }

  assert {
    condition     = azurerm_virtual_network.main.address_space[0] == "10.0.0.0/16"
    error_message = "Virtual network address space should be 10.0.0.0/16"
  }

  assert {
    condition     = azurerm_subnet.web.address_prefixes[0] == "10.0.1.0/24"
    error_message = "Web subnet address prefix should be 10.0.1.0/24"
  }

  assert {
    condition     = azurerm_subnet.app.address_prefixes[0] == "10.0.2.0/24"
    error_message = "App subnet address prefix should be 10.0.2.0/24"
  }

  assert {
    condition     = azurerm_subnet.database.address_prefixes[0] == "10.0.3.0/24"
    error_message = "Database subnet address prefix should be 10.0.3.0/24"
  }

  assert {
    condition     = azurerm_network_security_group.web.name == "nsg-web"
    error_message = "Web NSG name should be nsg-web"
  }

  assert {
    condition     = azurerm_network_security_group.app.name == "nsg-app"
    error_message = "App NSG name should be nsg-app"
  }

  assert {
    condition     = azurerm_network_security_group.database.name == "nsg-database"
    error_message = "Database NSG name should be nsg-database"
  }
}

run "custom_address_space" {
  command = plan

  variables {
    resource_group_name = "test-rg-custom"
    location           = "westus2"
    virtual_network_address_space = ["192.168.0.0/16"]
    web_subnet_address_prefixes = ["192.168.1.0/24"]
    app_subnet_address_prefixes = ["192.168.2.0/24"]
    database_subnet_address_prefixes = ["192.168.3.0/24"]
  }

  assert {
    condition     = azurerm_virtual_network.main.address_space[0] == "192.168.0.0/16"
    error_message = "Virtual network address space should be 192.168.0.0/16"
  }
}

run "load_balancer_creation" {
  command = plan

  variables {
    resource_group_name = "test-rg-lb"
    location           = "eastus"
    create_web_load_balancer = true
    create_app_load_balancer = true
  }

  assert {
    condition     = azurerm_lb.web[0].name == "lb-web"
    error_message = "Web load balancer should be created with correct name"
  }

  assert {
    condition     = azurerm_lb.app[0].name == "lb-app"
    error_message = "App load balancer should be created with correct name"
  }
}

run "application_gateway_creation" {
  command = plan

  variables {
    resource_group_name = "test-rg-agw"
    location           = "eastus"
    create_application_gateway = true
  }

  assert {
    condition     = azurerm_application_gateway.main[0].name == "agw-main"
    error_message = "Application Gateway should be created with correct name"
  }

  assert {
    condition     = azurerm_subnet.app_gateway[0].name == "snet-appgateway"
    error_message = "Application Gateway subnet should be created"
  }
}

run "bastion_host_creation" {
  command = plan

  variables {
    resource_group_name = "test-rg-bastion"
    location           = "eastus"
    create_bastion_host = true
  }

  assert {
    condition     = azurerm_bastion_host.main[0].name == "bas-main"
    error_message = "Bastion host should be created with correct name"
  }

  assert {
    condition     = azurerm_subnet.bastion[0].name == "snet-bastion"
    error_message = "Bastion subnet should be created"
  }
}

run "route_tables_creation" {
  command = plan

  variables {
    resource_group_name = "test-rg-routes"
    location           = "eastus"
    create_web_route_table = true
    create_app_route_table = true
    create_database_route_table = true
  }

  assert {
    condition     = azurerm_route_table.web[0].name == "rt-web"
    error_message = "Web route table should be created with correct name"
  }

  assert {
    condition     = azurerm_route_table.app[0].name == "rt-app"
    error_message = "App route table should be created with correct name"
  }

  assert {
    condition     = azurerm_route_table.database[0].name == "rt-database"
    error_message = "Database route table should be created with correct name"
  }
}

run "network_watcher_creation" {
  command = plan

  variables {
    resource_group_name = "test-rg-watcher"
    location           = "eastus"
    create_network_watcher = true
  }

  assert {
    condition     = azurerm_network_watcher.main[0].name == "nw-main"
    error_message = "Network Watcher should be created with correct name"
  }
}

run "validation_errors" {
  command = plan

  variables {
    resource_group_name = "invalid-name-with-special-chars!"
    location           = "invalid-location"
  }

  expect_failures = [
    var.resource_group_name,
    var.location
  ]
} 