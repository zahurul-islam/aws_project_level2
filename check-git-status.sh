#!/bin/bash

# Git Status Check Script for Terraform Project
# This script helps verify that .gitignore is working correctly

echo "🔍 Git Status Check for Terraform Project"
echo "========================================"

# Check if we're in a git repository
if [ ! -d ".git" ]; then
    echo "❌ Not in a git repository. Run 'git init' first."
    exit 1
fi

echo "📁 Current directory: $(pwd)"
echo ""

# Show current git status
echo "📊 Current Git Status:"
echo "--------------------"
git status

echo ""
echo "🔍 Checking for potentially sensitive files..."
echo "=============================================="

# Check for common sensitive files that should be ignored
sensitive_files=(
    "terraform/terraform.tfvars"
    "terraform/*.tfstate"
    "terraform/*.tfstate.backup"
    "terraform/.terraform/"
    "terraform/crash.log"
    "terraform/*.pem"
    "terraform/*.key"
    ".aws/credentials"
    ".env"
)

found_sensitive=false

for file_pattern in "${sensitive_files[@]}"; do
    if ls $file_pattern 2>/dev/null; then
        if git check-ignore $file_pattern >/dev/null 2>&1; then
            echo "✅ $file_pattern - properly ignored"
        else
            echo "⚠️  $file_pattern - EXISTS but NOT IGNORED!"
            found_sensitive=true
        fi
    fi
done

echo ""
echo "📝 Files that would be committed:"
echo "================================"
git diff --cached --name-only
if [ -z "$(git diff --cached --name-only)" ]; then
    echo "   (no files staged for commit)"
fi

echo ""
echo "📝 Untracked files:"
echo "=================="
git ls-files --others --exclude-standard
if [ -z "$(git ls-files --others --exclude-standard)" ]; then
    echo "   (no untracked files)"
fi

echo ""
if [ "$found_sensitive" = true ]; then
    echo "⚠️  WARNING: Some sensitive files are not being ignored!"
    echo "   Please check your .gitignore file and add these patterns."
    echo "   Never commit files containing passwords, keys, or state data."
else
    echo "✅ Security check passed! No sensitive files detected in git tracking."
fi

echo ""
echo "💡 Tips:"
echo "  - Always run this script before committing"
echo "  - Copy terraform.tfvars.example to terraform.tfvars for your local config"
echo "  - Your terraform.tfvars should never be committed (contains sensitive data)"
echo "  - Use 'git add .' carefully and review with 'git status' first"
