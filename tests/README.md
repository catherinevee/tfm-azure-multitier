# Testing Framework for tfm-azure-dmz

This directory contains the testing framework for the tfm-azure-dmz Terraform module using Terraform's native testing capabilities.

## Overview

The testing framework uses Terraform's built-in testing features to validate module functionality, configuration validation, and error handling without requiring external testing tools.

## Test Structure

### Basic Tests (`basic.tftest.hcl`)

Tests basic module functionality and validation:

- **basic_deployment**: Validates default configuration and resource creation
- **custom_address_spaces**: Tests custom address space configurations
- **validation_errors**: Ensures proper error handling for invalid inputs
- **invalid_location**: Tests location validation
- **bastion_host_enabled**: Validates bastion host creation
- **application_gateway_enabled**: Validates application gateway creation

## Running Tests

### Prerequisites

- Terraform >= 1.13.0
- Azure provider ~> 4.38.1
- Azure CLI configured with appropriate credentials

### Commands

```bash
# Run all tests
terraform test

# Run specific test file
terraform test tests/basic.tftest.hcl

# Run with verbose output
terraform test -verbose

# Run with detailed output
terraform test -verbose -detailed-exitcode
```

### Test Output

Tests will output:
- ✅ **PASS**: Test completed successfully
- ❌ **FAIL**: Test failed (assertion or expectation not met)
- ⚠️ **SKIP**: Test was skipped due to configuration

## Test Types

### Plan Tests

Most tests use the `plan` command to validate:
- Resource creation and configuration
- Variable validation
- Output values
- Error conditions

### Validation Tests

Tests that expect failures:
- Invalid resource group names
- Invalid locations
- Malformed configurations

### Assertion Tests

Tests that validate specific conditions:
- Default values are applied correctly
- Custom configurations are respected
- Resource relationships are established

## Adding New Tests

### Test Structure

```hcl
run "test_name" {
  command = plan

  variables {
    # Test variables
  }

  assert {
    condition     = resource.attribute == expected_value
    error_message = "Descriptive error message"
  }

  # For tests expecting failures
  expect_failures = [
    var.variable_name,
  ]
}
```

### Best Practices

1. **Descriptive Names**: Use clear, descriptive test names
2. **Focused Tests**: Each test should validate one specific aspect
3. **Meaningful Assertions**: Assertions should be specific and meaningful
4. **Error Messages**: Provide clear error messages for failures
5. **Coverage**: Test both success and failure scenarios

### Test Categories

- **Unit Tests**: Test individual components and configurations
- **Integration Tests**: Test component interactions
- **Validation Tests**: Test input validation and error handling
- **Edge Cases**: Test boundary conditions and unusual configurations

## Test Coverage

### Current Coverage

- ✅ Basic module deployment
- ✅ Custom configurations
- ✅ Input validation
- ✅ Error handling
- ✅ Optional components (bastion, application gateway)
- ✅ Resource relationships

### Planned Coverage

- 🔄 Advanced configurations
- 🔄 Performance testing
- 🔄 Security validation
- 🔄 Cost optimization scenarios

## Troubleshooting

### Common Issues

1. **Provider Configuration**: Ensure Azure provider is properly configured
2. **Credentials**: Verify Azure CLI authentication
3. **Resource Limits**: Check Azure subscription limits
4. **Network Access**: Ensure network access for Azure resources

### Debugging

```bash
# Enable debug logging
export TF_LOG=DEBUG
terraform test

# Check specific test
terraform test -verbose tests/basic.tftest.hcl
```

### Test Isolation

Tests are designed to be isolated and should not interfere with each other. Each test uses unique resource names and configurations.

## Continuous Integration

### GitHub Actions

Tests can be integrated into CI/CD pipelines:

```yaml
- name: Run Terraform Tests
  run: |
    terraform init
    terraform test
```

### Local Development

For local development:

```bash
# Run tests before committing
terraform test

# Run specific test during development
terraform test tests/basic.tftest.hcl
```

## Contributing

When adding new tests:

1. Follow the existing test structure
2. Add appropriate assertions
3. Include error handling tests
4. Update this documentation
5. Ensure tests pass locally before submitting

## Resources

- [Terraform Testing Documentation](https://developer.hashicorp.com/terraform/language/tests)
- [Azure Provider Documentation](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)
- [Terraform Best Practices](https://developer.hashicorp.com/terraform/language/best-practices) 