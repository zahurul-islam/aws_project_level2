# Git Configuration for Multi-AZ WordPress Terraform Project

## Important Security Notice

This `.gitignore` file is configured to protect sensitive information from being accidentally committed to version control.

## What's Being Ignored and Why

### 🔐 **Critical Security Files**
- `*.tfvars` - Contains sensitive data like passwords, API keys
- `*.tfstate*` - Contains current infrastructure state (may include sensitive data)
- `*.pem`, `*.key` - SSH private keys
- `.aws/`, `credentials` - AWS credentials files
- `.env*` - Environment variables files

### 🛠️ **Terraform Working Files**
- `.terraform/` - Terraform working directory with providers and modules
- `crash.log` - Terraform crash logs
- `*tfplan*` - Terraform plan output files
- `override.tf*` - Local override files
- `.terraform.lock.hcl` - Provider version locks (optional to ignore)

### 💻 **Development Environment**
- `.vscode/`, `.idea/` - IDE configuration
- `*.swp`, `*.swo` - Editor temporary files
- `.DS_Store` - macOS system files
- `Thumbs.db` - Windows system files

## What Should Be Committed

✅ **Safe to commit:**
- `*.tf` files (main Terraform configuration)
- `terraform.tfvars.example` (example without sensitive data)
- `README.md`, documentation files
- `deploy.sh`, `cleanup.sh` (utility scripts)
- `userdata.sh` (installation scripts)

❌ **Never commit:**
- `terraform.tfvars` (contains your actual passwords and keys)
- `*.tfstate` files (contains infrastructure state and sensitive data)
- SSH private keys or AWS credentials
- Any file with actual passwords, API keys, or secrets

## Setting Up Git Repository

To initialize a git repository for this project:

```bash
# Navigate to project root
cd /home/zahurul/Documents/work/AWS_lab/capstone/aws_project_level2

# Initialize git repository
git init

# Add all files (respecting .gitignore)
git add .

# Create initial commit
git commit -m "Initial commit: Multi-AZ WordPress Terraform configuration"

# Add remote repository (replace with your actual repository URL)
# git remote add origin https://github.com/yourusername/multi-az-wordpress.git
# git push -u origin main
```

## Before First Commit

1. **Review .gitignore**: Ensure all sensitive files are properly ignored
2. **Check terraform.tfvars**: Make sure it's ignored and not staged
3. **Verify no secrets**: Run `git status` to check no sensitive files are staged
4. **Create terraform.tfvars**: Copy from example and add your actual values (this stays local)

## Best Practices

- Always use `terraform.tfvars.example` for sharing configuration templates
- Document any required environment variables in README.md
- Use AWS IAM roles and policies instead of hardcoded credentials when possible
- Regularly audit what files are being tracked with `git ls-files`

## Security Reminder

🚨 **Never commit sensitive data!** If you accidentally commit sensitive information:
1. Remove it from the repository history
2. Rotate any exposed credentials immediately
3. Use tools like `git-secrets` to prevent future accidents
