#!/bin/bash

# Multi-AZ WordPress Cleanup Script
# This script helps destroy the Terraform infrastructure

set -e

echo "🧹 Multi-AZ WordPress Cleanup Script"
echo "===================================="

# Check if terraform is installed
if ! command -v terraform &> /dev/null; then
    echo "❌ Terraform is not installed."
    exit 1
fi

# Check if terraform state exists
if [ ! -f "terraform.tfstate" ]; then
    echo "⚠️  No Terraform state found. Nothing to destroy."
    exit 0
fi

echo "⚠️  WARNING: This will destroy ALL resources created by Terraform!"
echo "This includes:"
echo "- EC2 instances"
echo "- Load balancer"
echo "- VPC and all networking components"
echo "- Security groups"
echo "- Auto Scaling Group"
echo "- All data will be permanently lost!"
echo ""
echo "❓ Are you ABSOLUTELY sure you want to proceed? (type 'yes' to confirm)"
read -r response

if [[ "$response" == "yes" ]]; then
    echo "🧹 Destroying infrastructure..."
    terraform destroy -auto-approve
    
    echo "✅ All resources have been destroyed!"
    echo "💡 Tip: You can redeploy anytime using ./deploy.sh"
    
else
    echo "❌ Cleanup cancelled"
    exit 0
fi
