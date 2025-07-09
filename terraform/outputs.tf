output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.main.id
}

output "vpc_cidr_block" {
  description = "CIDR block of the VPC"
  value       = aws_vpc.main.cidr_block
}

output "public_subnet_ids" {
  description = "IDs of the public subnets"
  value       = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  description = "IDs of the private subnets"
  value       = aws_subnet.private[*].id
}

output "internet_gateway_id" {
  description = "ID of the Internet Gateway"
  value       = aws_internet_gateway.main.id
}

output "nat_gateway_id" {
  description = "ID of the NAT Gateway"
  value       = var.enable_nat_gateway ? aws_nat_gateway.main[0].id : null
}

output "load_balancer_dns_name" {
  description = "DNS name of the load balancer"
  value       = aws_lb.main.dns_name
}

output "load_balancer_zone_id" {
  description = "Zone ID of the load balancer"
  value       = aws_lb.main.zone_id
}

output "wordpress_url" {
  description = "URL to access WordPress application"
  value       = "http://${aws_lb.main.dns_name}"
}

output "bastion_public_ip" {
  description = "Public IP of the bastion host"
  value       = var.enable_bastion ? aws_instance.bastion[0].public_ip : null
}

output "auto_scaling_group_name" {
  description = "Name of the Auto Scaling Group"
  value       = aws_autoscaling_group.wordpress.name
}

output "target_group_arn" {
  description = "ARN of the target group"
  value       = aws_lb_target_group.wordpress.arn
}

output "security_group_alb_id" {
  description = "ID of the ALB security group"
  value       = aws_security_group.alb.id
}

output "security_group_wordpress_id" {
  description = "ID of the WordPress security group"
  value       = aws_security_group.wordpress.id
}

output "security_group_bastion_id" {
  description = "ID of the bastion security group"
  value       = var.enable_bastion ? aws_security_group.bastion[0].id : null
}
