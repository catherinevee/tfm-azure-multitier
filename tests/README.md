# Testing Guide for tfm-azure-multitier

This directory contains tests for the Azure Multi-Tier Architecture Terraform module.

## Test Structure

- `basic.tftest.hcl` - Basic functionality tests
- `integration.tftest.hcl` - Integration tests (planned)
- `security.tftest.hcl` - Security validation tests (planned)

## Running Tests

### Prerequisites

- Terraform >= 1.13.0
- Azure provider >= 4.38.1
- Azure CLI configured with appropriate permissions

### Basic Tests

```bash
# Run all tests
terraform test

# Run specific test file
terraform test tests/basic.tftest.hcl

# Run with verbose output
terraform test -verbose
```

### Test Types

#### 1. Basic Deployment Test
- Validates default configuration
- Checks address space assignments
- Verifies subnet configurations

#### 2. Custom Address Space Test
- Tests custom CIDR configurations
- Validates custom subnet assignments

#### 3. Validation Error Test
- Ensures proper error handling
- Validates input constraints

## Adding New Tests

When adding new tests:

1. Create a new `.tftest.hcl` file
2. Use descriptive test names
3. Include appropriate assertions
4. Test both success and failure scenarios
5. Document any special requirements

## Test Best Practices

- Use isolated resource names to avoid conflicts
- Clean up test resources after completion
- Test edge cases and error conditions
- Validate both plan and apply operations
- Include cost estimation tests for expensive resources

## Continuous Integration

Tests can be integrated into CI/CD pipelines:

```yaml
# Example GitHub Actions step
- name: Run Terraform Tests
  run: |
    terraform init
    terraform test
```

## Troubleshooting

### Common Issues

1. **Provider Version Mismatch**: Ensure you're using the correct provider version
2. **Authentication**: Verify Azure CLI is properly configured
3. **Resource Conflicts**: Use unique resource names in tests
4. **Network Issues**: Ensure proper network connectivity for Azure API calls

### Debug Mode

Run tests with debug output:

```bash
export TF_LOG=DEBUG
terraform test -verbose
``` 