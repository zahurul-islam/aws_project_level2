# Multi-AZ WordPress Deployment on AWS

This Terraform configuration deploys a highly available WordPress application across multiple Availability Zones on AWS, designed to work within the AWS Free Tier limits.

## Architecture Overview

- **VPC**: Custom VPC with public and private subnets across 2 AZs
- **Load Balancer**: Application Load Balancer distributing traffic
- **Auto Scaling**: Auto Scaling Group with CloudWatch-based scaling
- **Security**: Security groups for different tiers
- **Optional Components**: Bastion host and NAT Gateway

## Features

✅ **Multi-AZ Deployment**: Resources distributed across multiple availability zones  
✅ **Auto Scaling**: Automatic scaling based on CPU utilization  
✅ **Load Balancing**: Application Load Balancer for high availability  
✅ **Security Groups**: Proper network security configuration  
✅ **Automated Setup**: Fully automated WordPress installation via user data  
✅ **Free Tier Compatible**: Designed to work within AWS Free Tier limits  
✅ **Optional Bastion**: Secure access via bastion host  
✅ **Optional NAT Gateway**: Internet access for private instances (costs extra)  

## Prerequisites

1. **AWS Account** with appropriate permissions
2. **Terraform** installed (version >= 1.0)
3. **AWS CLI** configured with your credentials
4. **EC2 Key Pair** created in your target region

## Quick Start

1. **Clone and Navigate**:
   ```bash
   cd terraform
   ```

2. **Configure Variables**:
   ```bash
   cp terraform.tfvars.example terraform.tfvars
   # Edit terraform.tfvars with your settings
   ```

3. **Initialize Terraform**:
   ```bash
   terraform init
   ```

4. **Plan Deployment**:
   ```bash
   terraform plan
   ```

5. **Deploy**:
   ```bash
   terraform apply
   ```

6. **Access WordPress**:
   - Get the load balancer URL from terraform output
   - Open the URL in your browser
   - Complete WordPress setup

## Configuration Options

### Essential Variables (must be changed)

- `key_pair_name`: Your AWS EC2 key pair name
- `db_password`: Strong password for the database

### Optional Variables

- `enable_bastion`: Enable bastion host (default: false)
- `enable_nat_gateway`: Enable NAT Gateway (costs money, default: false)
- `instance_type`: EC2 instance type (default: t2.micro for free tier)
- `desired_capacity`: Number of WordPress instances (default: 2)

## Cost Considerations

### Free Tier Components
- EC2 instances (t2.micro, up to 750 hours/month)
- Application Load Balancer (750 hours/month)
- VPC and related networking (free)
- CloudWatch alarms (10 alarms free)

### Paid Components (optional)
- NAT Gateway (~$45/month) - set `enable_nat_gateway = false` to avoid costs
- Data transfer charges (minimal for typical usage)

## Security Notes

1. **Database**: Runs locally on EC2 instances for simplicity
2. **SSH Access**: 
   - With bastion: SSH through bastion host
   - Without bastion: Direct SSH to instances (less secure)
3. **Network**: Private subnets protect application instances
4. **Security Groups**: Restricted access between tiers

## File Structure

```
terraform/
├── main.tf                    # Provider and data sources
├── variables.tf               # Variable definitions
├── vpc.tf                     # VPC and networking
├── security-groups.tf         # Security group definitions
├── load-balancer.tf          # Application Load Balancer
├── ec2.tf                    # EC2 instances and Auto Scaling
├── outputs.tf                # Output values
├── userdata.sh               # WordPress installation script
├── terraform.tfvars.example  # Example variables file
└── README.md                 # This file
```

## Outputs

After deployment, you'll get:
- WordPress URL (load balancer DNS name)
- VPC and subnet IDs
- Security group IDs
- Bastion host IP (if enabled)

## Troubleshooting

### Common Issues

1. **Key Pair Error**: Ensure your key pair exists in the target region
2. **Permission Denied**: Check AWS credentials and IAM permissions
3. **Instance Launch Fails**: Verify AMI availability in your region
4. **WordPress Not Loading**: Check security groups and user data logs

### Debugging

- SSH into instances to check logs: `/var/log/cloud-init-output.log`
- Check Auto Scaling Group activity
- Verify load balancer health checks

## Cleanup

To destroy all resources:
```bash
terraform destroy
```

**Note**: This will delete all resources and data. Make sure to backup any important data first.

## Support

For issues with this Terraform configuration, check:
1. AWS CloudFormation events for detailed error messages
2. EC2 instance logs via SSH
3. Auto Scaling Group activity tab
4. Load balancer health check status

## License

This project is provided as-is for educational and demonstration purposes.
