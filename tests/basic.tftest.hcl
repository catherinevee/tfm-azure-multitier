# Basic test for tfm-azure-multitier module
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