# Basic test configuration for tfm-azure-dmz module
# Tests basic deployment validation and error scenarios

run "basic_deployment" {
  command = plan

  variables {
    resource_group_name = "test-rg"
    location           = "eastus"
  }

  assert {
    condition     = azurerm_virtual_network.main.address_space == ["10.0.0.0/16"]
    error_message = "Virtual network should have default address space"
  }

  assert {
    condition     = azurerm_subnet.web.address_prefixes == ["10.0.1.0/24"]
    error_message = "Web subnet should have default address prefix"
  }

  assert {
    condition     = azurerm_subnet.app.address_prefixes == ["10.0.2.0/24"]
    error_message = "App subnet should have default address prefix"
  }

  assert {
    condition     = azurerm_subnet.database.address_prefixes == ["10.0.3.0/24"]
    error_message = "Database subnet should have default address prefix"
  }
}

run "custom_address_spaces" {
  command = plan

  variables {
    resource_group_name              = "test-rg"
    location                        = "eastus"
    virtual_network_address_space   = ["192.168.0.0/16"]
    web_subnet_address_prefixes     = ["192.168.1.0/24"]
    app_subnet_address_prefixes     = ["192.168.2.0/24"]
    database_subnet_address_prefixes = ["192.168.3.0/24"]
  }

  assert {
    condition     = azurerm_virtual_network.main.address_space == ["192.168.0.0/16"]
    error_message = "Virtual network should use custom address space"
  }

  assert {
    condition     = azurerm_subnet.web.address_prefixes == ["192.168.1.0/24"]
    error_message = "Web subnet should use custom address prefix"
  }
}

run "validation_errors" {
  command = plan

  variables {
    resource_group_name = "invalid-resource-group-name-with-very-long-name-that-exceeds-the-maximum-allowed-length-of-ninety-characters"
    location           = "eastus"
  }

  expect_failures = [
    var.resource_group_name,
  ]
}

run "invalid_location" {
  command = plan

  variables {
    resource_group_name = "test-rg"
    location           = "invalid-location"
  }

  expect_failures = [
    var.location,
  ]
}

run "bastion_host_enabled" {
  command = plan

  variables {
    resource_group_name = "test-rg"
    location           = "eastus"
    create_bastion_host = true
  }

  assert {
    condition     = azurerm_bastion_host.main[0].name == "bastion-multitier"
    error_message = "Bastion host should be created with default name"
  }

  assert {
    condition     = azurerm_subnet.bastion[0].name == "snet-bastion"
    error_message = "Bastion subnet should be created"
  }
}

run "application_gateway_enabled" {
  command = plan

  variables {
    resource_group_name        = "test-rg"
    location                  = "eastus"
    create_application_gateway = true
  }

  assert {
    condition     = azurerm_application_gateway.main[0].name == "appgw-multitier"
    error_message = "Application gateway should be created with default name"
  }

  assert {
    condition     = azurerm_subnet.app_gateway[0].name == "snet-appgateway"
    error_message = "Application gateway subnet should be created"
  }
} 