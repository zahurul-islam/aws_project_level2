#!/bin/bash

# Multi-AZ WordPress Deployment Script
# This script helps deploy the Terraform configuration

set -e

echo "🚀 Multi-AZ WordPress Deployment Script"
echo "========================================"

# Check if terraform is installed
if ! command -v terraform &> /dev/null; then
    echo "❌ Terraform is not installed. Please install Terraform first."
    exit 1
fi

# Check if AWS CLI is installed
if ! command -v aws &> /dev/null; then
    echo "❌ AWS CLI is not installed. Please install AWS CLI first."
    exit 1
fi

# Check AWS credentials
if ! aws sts get-caller-identity &> /dev/null; then
    echo "❌ AWS credentials not configured. Please run 'aws configure' first."
    exit 1
fi

echo "✅ Prerequisites check passed"

# Check if terraform.tfvars exists
if [ ! -f "terraform.tfvars" ]; then
    echo "⚠️  terraform.tfvars not found. Creating from example..."
    cp terraform.tfvars.example terraform.tfvars
    echo "📝 Please edit terraform.tfvars with your settings (especially key_pair_name and db_password)"
    echo "⏸️  Press Enter to continue after editing terraform.tfvars..."
    read
fi

# Initialize Terraform
echo "🔧 Initializing Terraform..."
terraform init

# Validate configuration
echo "✅ Validating Terraform configuration..."
terraform validate

# Show plan
echo "📋 Showing deployment plan..."
terraform plan

# Confirm deployment
echo "❓ Do you want to proceed with deployment? (yes/no)"
read -r response

if [[ "$response" == "yes" ]]; then
    echo "🚀 Deploying infrastructure..."
    terraform apply -auto-approve
    
    echo "🎉 Deployment completed!"
    echo ""
    echo "📊 Deployment Summary:"
    echo "====================="
    terraform output
    
    echo ""
    echo "🌐 To access WordPress:"
    echo "1. Wait 2-3 minutes for instances to fully initialize"
    echo "2. Open the WordPress URL shown above"
    echo "3. Complete the WordPress setup wizard"
    echo ""
    echo "🔧 To SSH into instances (if bastion enabled):"
    echo "ssh -i your-key.pem ec2-user@bastion-ip"
    echo "Then from bastion: ssh ec2-user@private-instance-ip"
    
else
    echo "❌ Deployment cancelled"
    exit 0
fi
