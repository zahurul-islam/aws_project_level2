# Multi-AZ WordPress Deployment on AWS

[![Terraform](https://img.shields.io/badge/Terraform-1.0+-623CE4?style=flat&logo=terraform)](https://terraform.io)
[![AWS](https://img.shields.io/badge/AWS-Free%20Tier-FF9900?style=flat&logo=amazon-aws)](https://aws.amazon.com/free/)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

> **Production-ready, highly available WordPress deployment across multiple AWS Availability Zones using Terraform, designed for AWS Free Tier compatibility.**

## 🏗️ Architecture Overview

This project deploys a robust, scalable WordPress infrastructure that automatically distributes across multiple AWS Availability Zones for high availability and fault tolerance.

```
┌─────────────────────────────────────────────────────────────┐
│                        Internet Gateway                      │
└─────────────────────┬───────────────────────────────────────┘
                      │
    ┌─────────────────┴───────────────────┐
    │        Application Load Balancer     │
    │         (Multi-AZ Distribution)      │
    └─────────────┬─────────────┬─────────┘
                  │             │
        ┌─────────▼─────────┐ ┌─▼─────────────┐
        │  Public Subnet    │ │ Public Subnet │
        │      (AZ-1)       │ │     (AZ-2)    │
        └─────────┬─────────┘ └─┬─────────────┘
                  │             │
        ┌─────────▼─────────┐ ┌─▼─────────────┐
        │ Private Subnet    │ │Private Subnet │
        │  WordPress EC2    │ │ WordPress EC2 │
        │     (AZ-1)        │ │    (AZ-2)     │
        └───────────────────┘ └───────────────┘
```

## ✨ Key Features

### 🚀 **High Availability & Scalability**
- **Multi-AZ Deployment** across 2+ availability zones
- **Auto Scaling Group** with intelligent CPU-based scaling (1-3 instances)
- **Application Load Balancer** with health checks and traffic distribution
- **CloudWatch Integration** for monitoring and automated scaling decisions

### 🛡️ **Security First**
- **Multi-tier Security Groups** with least privilege access
- **Private Subnets** for application instances
- **Optional Bastion Host** for secure SSH access
- **Git Security** with comprehensive `.gitignore` protection
- **Automated Security Checks** before commits

### 💰 **Cost Optimized**
- **AWS Free Tier Compatible** - designed to minimize costs
- **t2.micro instances** (750 hours/month free)
- **Free Application Load Balancer** (750 hours/month free)
- **Optional components** to avoid unnecessary charges
- **Smart defaults** that keep you within free tier limits

### 🔧 **Developer Experience**
- **Fully Automated Deployment** via single script execution
- **Infrastructure as Code** with Terraform best practices
- **One-Click Cleanup** for complete resource removal
- **Comprehensive Documentation** and troubleshooting guides
- **Security Verification Tools** for safe version control

## 🎯 What You Get

After deployment, you'll have:

✅ **Production-Ready WordPress** with automatic installation  
✅ **High Availability** across multiple data centers  
✅ **Automatic Scaling** based on traffic demands  
✅ **Load Balancing** for optimal performance  
✅ **Secure Network Architecture** with proper isolation  
✅ **Monitoring & Alerting** via CloudWatch  
✅ **Easy Management** through AWS console integration  

## 🚀 Quick Start

### Prerequisites

- **AWS Account** with administrative access
- **Terraform** 1.0+ installed ([Download](https://terraform.io/downloads))
- **AWS CLI** configured ([Setup Guide](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html))
- **EC2 Key Pair** created in your target AWS region

### 1️⃣ Clone and Setup

```bash
# Clone the repository
git clone https://github.com/zahurul-islam/aws_project_level2.git
cd aws_project_level2

# Verify git security
./check-git-status.sh
```

### 2️⃣ Configure Your Deployment

```bash
# Navigate to terraform directory
cd terraform

# Create your configuration from template
cp terraform.tfvars.example terraform.tfvars

# Edit with your actual values (this file stays local and secure)
nano terraform.tfvars
```

**Essential Configuration (MUST change):**
```hcl
key_pair_name = "your-actual-key-pair-name"    # Your AWS key pair
db_password = "YourSecurePassword123!"         # Strong database password
aws_region = "us-east-1"                       # Your preferred region
```

### 3️⃣ Deploy Infrastructure

```bash
# Automated deployment with safety checks
./deploy.sh
```

The script will:
- ✅ Verify prerequisites  
- ✅ Initialize Terraform  
- ✅ Show deployment plan  
- ✅ Deploy infrastructure  
- ✅ Provide access URLs  

### 4️⃣ Access Your WordPress Site

1. **Get URL**: Check terraform output for load balancer DNS name
2. **Wait**: Allow 2-3 minutes for full initialization
3. **Setup**: Complete WordPress installation wizard
4. **Enjoy**: Your high-availability WordPress is ready!

## 🏗️ Project Structure

```
aws_project_level2/
├── 📋 README.md                    # This comprehensive guide
├── 🔒 .gitignore                   # Security protection for sensitive files
├── 📖 GIT_SETUP.md                 # Git security documentation
├── 🔍 check-git-status.sh          # Security verification tool
│
└── terraform/                      # Infrastructure as Code
    ├── 🏠 main.tf                  # Provider and core configuration
    ├── 📊 variables.tf             # Configurable parameters
    ├── 🌐 vpc.tf                   # VPC and networking
    ├── 🛡️ security-groups.tf      # Security group definitions
    ├── ⚖️ load-balancer.tf        # Application Load Balancer
    ├── 🖥️ ec2.tf                  # EC2 instances and Auto Scaling
    ├── 📤 outputs.tf               # Deployment results
    ├── 🚀 userdata.sh              # WordPress installation script
    ├── 📝 terraform.tfvars.example # Configuration template
    ├── 🚀 deploy.sh                # Automated deployment
    ├── 🧹 cleanup.sh               # Resource cleanup
    └── 📚 README.md                # Terraform-specific documentation
```

## 💰 Cost Analysis

### ✅ **Free Tier Components**
- **EC2 Instances**: t2.micro (750 hours/month free)
- **Load Balancer**: Application LB (750 hours/month free)
- **VPC & Networking**: No charges for VPC, subnets, route tables
- **CloudWatch**: 10 alarms and basic monitoring (free)
- **Data Transfer**: 15 GB outbound per month (free)

### 💵 **Optional Paid Components**
- **NAT Gateway**: ~$45/month (disabled by default)
- **Bastion Host**: Free with t2.micro, but uses your 750-hour limit
- **Additional Data Transfer**: $0.09/GB after free tier

### 💡 **Cost Optimization Tips**
```hcl
# In terraform.tfvars
enable_nat_gateway = false   # Saves ~$45/month
enable_bastion = false       # Saves EC2 hours for main instances
desired_capacity = 1         # Start with 1 instance, scale up as needed
```

## 🔧 Configuration Options

### Essential Settings
```hcl
# terraform/terraform.tfvars
aws_region = "us-east-1"                    # Your AWS region
key_pair_name = "my-key-pair"               # Your EC2 key pair name
db_password = "SecurePassword123!"          # Strong database password
```

### Scaling Configuration
```hcl
min_size = 1              # Minimum instances
max_size = 3              # Maximum instances (free tier limit)
desired_capacity = 2      # Starting number of instances
instance_type = "t2.micro" # Free tier instance type
```

### Optional Features
```hcl
enable_bastion = true     # Enable bastion host for secure SSH
enable_nat_gateway = true # Enable internet access for private instances (costs money)
```

## 🔒 Security Features

### Git Security
- **Sensitive Data Protection**: `.gitignore` prevents accidental commits
- **Security Verification**: `check-git-status.sh` validates before commits
- **Local Configuration**: `terraform.tfvars` stays local and secure

### Infrastructure Security
- **Network Isolation**: Private subnets for application instances
- **Security Groups**: Least privilege access between tiers
- **SSH Access**: Optional bastion host or VPC-only access
- **Database Security**: Local MySQL with secure configuration

### Security Verification
```bash
# Always run before committing
./check-git-status.sh

# This script verifies:
# ✅ No sensitive files in git
# ✅ terraform.tfvars not committed
# ✅ No AWS credentials exposed
# ✅ Proper .gitignore protection
```

## 🛠️ Management & Operations

### Deployment
```bash
./terraform/deploy.sh              # Full automated deployment
```

### Monitoring
- **CloudWatch Dashboard**: Monitor CPU, memory, and network
- **Auto Scaling Activity**: View scaling events in AWS console
- **Load Balancer Health**: Check instance health status
- **Application Logs**: SSH to instances for detailed logs

### Scaling Operations
```bash
# Modify desired capacity
terraform apply -var="desired_capacity=3"

# Update instance type (within free tier)
terraform apply -var="instance_type=t3.micro"
```

### Cleanup
```bash
./terraform/cleanup.sh             # Remove all resources safely
```

## 🔧 Troubleshooting

### Common Issues

**🔍 WordPress Not Loading**
```bash
# Check instance status
aws ec2 describe-instances --region us-east-1

# Check load balancer health
aws elbv2 describe-target-health --target-group-arn <your-target-group-arn>

# SSH to instance and check logs
ssh -i your-key.pem ec2-user@instance-ip
sudo tail -f /var/log/cloud-init-output.log
```

**🔍 Auto Scaling Issues**
```bash
# Check Auto Scaling activity
aws autoscaling describe-scaling-activities --auto-scaling-group-name <asg-name>

# Check CloudWatch alarms
aws cloudwatch describe-alarms --region us-east-1
```

**🔍 Terraform Errors**
```bash
# Validate configuration
terraform validate

# Check for state issues
terraform refresh

# Detailed error output
terraform apply -auto-approve -debug
```

### Getting Help

1. **Check AWS CloudFormation Events** for detailed error messages
2. **Review Auto Scaling Group Activity** for scaling issues
3. **Examine Load Balancer Health Checks** for connectivity problems
4. **SSH into instances** to check application logs
5. **Validate security groups** for proper network access

## 🤝 Contributing

### Development Setup
```bash
# Clone and setup development environment
git clone <your-fork>
cd aws_project_level2

# Always verify security before commits
./check-git-status.sh

# Make changes, test thoroughly
cd terraform
terraform plan  # Verify changes

# Commit safely
git add .
git commit -m "feat: your improvement"
./check-git-status.sh  # Final security check
git push
```

### Contribution Guidelines
- **Security First**: Always run security checks before commits
- **Documentation**: Update docs for any configuration changes  
- **Testing**: Test changes in isolated AWS account
- **Code Style**: Follow Terraform best practices and naming conventions

## 📚 Additional Resources

- **[Terraform Documentation](https://terraform.io/docs)** - Official Terraform guides
- **[AWS Free Tier](https://aws.amazon.com/free/)** - Understanding free tier limits
- **[WordPress Security](https://wordpress.org/support/article/hardening-wordpress/)** - WordPress hardening guide
- **[AWS Well-Architected](https://aws.amazon.com/architecture/well-architected/)** - AWS best practices

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Built with [Terraform](https://terraform.io) for infrastructure as code
- Deployed on [AWS](https://aws.amazon.com) cloud platform
- Designed for [WordPress](https://wordpress.org) content management
- Follows AWS Well-Architected Framework principles

---

**💡 Pro Tip**: Start with the default configuration for learning, then customize based on your specific needs. The infrastructure scales with your requirements while maintaining cost efficiency.

**🚀 Ready to deploy?** Run `cd terraform && ./deploy.sh` and have your high-availability WordPress site running in minutes!
