#!/usr/bin/env pwsh

# Terragrunt Deployment Script for Cyprus AWS Environment
# This script deploys the complete AWS infrastructure for the accounts-client project
# 
# Requirements:
# - Terragrunt v0.84.0 or later
# - AWS CLI configured
# - Terraform v1.13.0 or later

param(
    [Parameter(Mandatory=$false)]
    [ValidateSet("plan", "apply", "destroy", "validate")]
    [string]$Action = "plan",
    
    [Parameter(Mandatory=$false)]
    [string]$Module = "all"
)

# Set error action preference
$ErrorActionPreference = "Stop"

# Colors for output
$Green = "`e[32m"
$Yellow = "`e[33m"
$Red = "`e[31m"
$Reset = "`e[0m"

# Function to write colored output
function Write-ColorOutput {
    param(
        [string]$Message,
        [string]$Color = $Reset
    )
    Write-Host "$Color$Message$Reset"
}

# Function to check if Terragrunt is installed and version is correct
function Test-Terragrunt {
    try {
        $version = terragrunt --version
        Write-ColorOutput "✓ Terragrunt is installed: $version" $Green
        
        # Extract version number and check if it's 0.84.0 or later
        if ($version -match "v(\d+\.\d+\.\d+)") {
            $terragruntVersion = $matches[1]
            $requiredVersion = "0.84.0"
            
            if ([System.Version]$terragruntVersion -ge [System.Version]$requiredVersion) {
                Write-ColorOutput "✓ Terragrunt version $terragruntVersion meets requirement (>= $requiredVersion)" $Green
                return $true
            } else {
                Write-ColorOutput "✗ Terragrunt version $terragruntVersion is below required version $requiredVersion" $Red
                Write-ColorOutput "Please upgrade Terragrunt to version $requiredVersion or later" $Yellow
                return $false
            }
        } else {
            Write-ColorOutput "⚠️  Could not determine Terragrunt version" $Yellow
            return $true
        }
    }
    catch {
        Write-ColorOutput "✗ Terragrunt is not installed or not in PATH" $Red
        Write-ColorOutput "Please install Terragrunt v0.84.0 or later from: https://terragrunt.gruntwork.io/docs/getting-started/install/" $Yellow
        return $false
    }
}

# Function to check if AWS CLI is configured
function Test-AWSConfig {
    try {
        $identity = aws sts get-caller-identity --query 'Arn' --output text 2>$null
        if ($identity) {
            Write-ColorOutput "✓ AWS CLI configured: $identity" $Green
            return $true
        }
        else {
            Write-ColorOutput "✗ AWS CLI not configured" $Red
            return $false
        }
    }
    catch {
        Write-ColorOutput "✗ AWS CLI not configured" $Red
        return $false
    }
}

# Function to check if Terraform is installed
function Test-Terraform {
    try {
        $version = terraform --version
        Write-ColorOutput "✓ Terraform is installed: $version" $Green
        return $true
    }
    catch {
        Write-ColorOutput "✗ Terraform is not installed or not in PATH" $Red
        Write-ColorOutput "Please install Terraform v1.13.0 or later" $Yellow
        return $false
    }
}

# Function to deploy a specific module
function Deploy-Module {
    param(
        [string]$ModulePath,
        [string]$Action
    )
    
    Write-ColorOutput "`n🔧 Processing module: $ModulePath" $Yellow
    
    Push-Location $ModulePath
    
    try {
        switch ($Action) {
            "validate" {
                Write-ColorOutput "Validating module..." $Yellow
                terragrunt validate
            }
            "plan" {
                Write-ColorOutput "Planning module..." $Yellow
                terragrunt plan
            }
            "apply" {
                Write-ColorOutput "Applying module..." $Yellow
                terragrunt apply -auto-approve
            }
            "destroy" {
                Write-ColorOutput "Destroying module..." $Yellow
                terragrunt destroy -auto-approve
            }
        }
        
        if ($LASTEXITCODE -eq 0) {
            Write-ColorOutput "✓ Module $ModulePath completed successfully" $Green
        }
        else {
            Write-ColorOutput "✗ Module $ModulePath failed" $Red
            exit $LASTEXITCODE
        }
    }
    finally {
        Pop-Location
    }
}

# Main execution
Write-ColorOutput "🚀 Terragrunt Deployment Script for Cyprus AWS Environment" $Green
Write-ColorOutput "Action: $Action" $Yellow
Write-ColorOutput "Module: $Module" $Yellow
Write-ColorOutput "Required Terragrunt Version: v0.84.0 or later" $Yellow

# Check prerequisites
if (-not (Test-Terragrunt)) {
    exit 1
}

if (-not (Test-Terraform)) {
    exit 1
}

if (-not (Test-AWSConfig)) {
    Write-ColorOutput "Please configure AWS CLI with: aws configure" $Yellow
    exit 1
}

# Define module deployment order (cleaned up - no unused modules)
$Modules = @(
    "vpc",
    "s3", 
    "iam",
    "rds",
    "alb",
    "ecs-cluster",
    "ecs-service",
    "cloudwatch"
)

# Deploy modules
if ($Module -eq "all") {
    Write-ColorOutput "`n📋 Deploying all modules in order..." $Green
    
    foreach ($module in $Modules) {
        $modulePath = Join-Path $PSScriptRoot $module
        if (Test-Path $modulePath) {
            Deploy-Module -ModulePath $modulePath -Action $Action
        }
        else {
            Write-ColorOutput "⚠️  Module path not found: $modulePath" $Yellow
        }
    }
}
else {
    $modulePath = Join-Path $PSScriptRoot $Module
    if (Test-Path $modulePath) {
        Deploy-Module -ModulePath $modulePath -Action $Action
    }
    else {
        Write-ColorOutput "✗ Module not found: $modulePath" $Red
        Write-ColorOutput "Available modules: $($Modules -join ', ')" $Yellow
        exit 1
    }
}

Write-ColorOutput "`n✅ Deployment completed successfully!" $Green

if ($Action -eq "apply") {
    Write-ColorOutput "`n📊 Next steps:" $Yellow
    Write-ColorOutput "1. Check the ALB DNS name in the AWS Console" $Yellow
    Write-ColorOutput "2. Verify ECS service is running" $Yellow
    Write-ColorOutput "3. Test the application endpoints" $Yellow
    Write-ColorOutput "4. Review CloudWatch metrics and alarms" $Yellow
} 