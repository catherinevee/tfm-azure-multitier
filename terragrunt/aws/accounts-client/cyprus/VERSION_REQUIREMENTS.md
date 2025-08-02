# Version Requirements - Cyprus AWS Infrastructure

## 📋 Software Version Requirements

This document specifies the required software versions for the Cyprus AWS infrastructure project.

---

## 🛠️ Required Software Versions

### **Terragrunt**
- **Required Version**: `v0.84.0` or later
- **Purpose**: Infrastructure as Code orchestration
- **Installation**: 
  ```bash
  # Windows (Chocolatey)
  choco install terragrunt
  
  # macOS (Homebrew)
  brew install terragrunt
  
  # Linux
  curl -fsSL https://github.com/gruntwork-io/terragrunt/releases/download/v0.84.0/terragrunt_linux_amd64 -o terragrunt
  chmod +x terragrunt
  sudo mv terragrunt /usr/local/bin/
  ```

### **Terraform**
- **Required Version**: `v1.13.0` or later
- **Purpose**: Infrastructure provisioning
- **Installation**:
  ```bash
  # Windows (Chocolatey)
  choco install terraform
  
  # macOS (Homebrew)
  brew install terraform
  
  # Linux
  curl -fsSL https://releases.hashicorp.com/terraform/1.13.0/terraform_1.13.0_linux_amd64.zip -o terraform.zip
  unzip terraform.zip
  sudo mv terraform /usr/local/bin/
  ```

### **AWS CLI**
- **Required Version**: `v2.0.0` or later
- **Purpose**: AWS service interaction
- **Installation**:
  ```bash
  # Windows
  # Download from: https://aws.amazon.com/cli/
  
  # macOS (Homebrew)
  brew install awscli
  
  # Linux
  curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
  unzip awscliv2.zip
  sudo ./aws/install
  ```

### **PowerShell** (for deployment script)
- **Required Version**: `v7.0.0` or later
- **Purpose**: Deployment automation
- **Installation**:
  ```bash
  # Windows (included with Windows 10/11)
  # For older versions, download from: https://github.com/PowerShell/PowerShell/releases
  
  # macOS (Homebrew)
  brew install powershell
  
  # Linux
  # Follow instructions at: https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell
  ```

---

## 🔧 AWS Provider Versions

### **AWS Provider**
- **Version**: `~> 6.2.0`
- **Purpose**: AWS resource management
- **Configuration**: Automatically managed by Terragrunt

### **Random Provider**
- **Version**: `~> 3.6.0`
- **Purpose**: Random value generation
- **Configuration**: Automatically managed by Terragrunt

---

## 📦 Terraform Module Versions

| Module | Source | Version | Purpose |
|--------|--------|---------|---------|
| **VPC** | `terraform-aws-modules/vpc/aws` | `5.8.1` | Network infrastructure |
| **RDS** | `terraform-aws-modules/rds/aws` | `6.8.0` | Database management |
| **ECS Cluster** | `terraform-aws-modules/ecs/aws//modules/cluster` | `5.7.4` | Container orchestration |
| **ECS Service** | `terraform-aws-modules/ecs/aws//modules/service` | `5.7.4` | Application deployment |
| **ALB** | `terraform-aws-modules/alb/aws` | `9.9.2` | Load balancing |
| **S3** | `terraform-aws-modules/s3-bucket/aws` | `4.1.2` | Object storage |
| **CloudWatch** | `terraform-aws-modules/cloudwatch/aws//modules/log-group` | `4.3.2` | Monitoring and logging |
| **IAM** | `terraform-aws-modules/iam/aws//modules/iam-role` | `5.30.0` | Identity and access management |

---

## 🧪 Testing Framework Versions

### **Terratest**
- **Version**: `v0.46.0` or later
- **Purpose**: Infrastructure testing
- **Installation**:
  ```bash
  go get github.com/gruntwork-io/terratest/modules/terraform
  go get github.com/gruntwork-io/terratest/modules/aws
  go get github.com/stretchr/testify/assert
  ```

### **Go**
- **Version**: `v1.21.0` or later
- **Purpose**: Test framework runtime
- **Installation**: Download from https://golang.org/dl/

---

## 🔍 Version Verification

### **Check Terragrunt Version**
```bash
terragrunt --version
# Expected output: terragrunt version v0.84.0
```

### **Check Terraform Version**
```bash
terraform --version
# Expected output: Terraform v1.13.0
```

### **Check AWS CLI Version**
```bash
aws --version
# Expected output: aws-cli/2.x.x
```

### **Check PowerShell Version**
```powershell
$PSVersionTable.PSVersion
# Expected output: Major 7, Minor 0, Patch 0
```

---

## 🚨 Version Compatibility Notes

### **Terragrunt v0.84.0 Features**
- Enhanced dependency management
- Improved state handling
- Better error reporting
- Support for latest Terraform features

### **Terraform v1.13.0 Features**
- Enhanced provider management
- Improved validation
- Better error messages
- Support for latest AWS provider features

### **AWS Provider v6.2.0 Features**
- Latest AWS service support
- Enhanced security features
- Improved resource management
- Better tagging support

---

## 📝 Version Update Policy

### **When to Update**
- **Security patches**: Update immediately
- **Bug fixes**: Update within 1 month
- **Feature updates**: Update within 3 months
- **Major versions**: Test thoroughly before updating

### **Update Process**
1. **Test in development environment**
2. **Update version requirements**
3. **Update documentation**
4. **Deploy to staging**
5. **Deploy to production**

---

## 🔗 Useful Links

- **Terragrunt**: https://terragrunt.gruntwork.io/
- **Terraform**: https://www.terraform.io/
- **AWS CLI**: https://aws.amazon.com/cli/
- **PowerShell**: https://docs.microsoft.com/en-us/powershell/
- **Go**: https://golang.org/
- **Terratest**: https://terratest.gruntwork.io/

---

**Last Updated**: January 2025  
**Project**: Cyprus AWS Infrastructure  
**Environment**: Production 