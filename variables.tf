variable "aws_region" {
  type        = string
  description = "AWS region for resource deployment"
  default     = "eu-central-1"
}

variable "vpc_cidr_block" {
  type        = string
  description = "CIDR block for VPC"
  default     = "10.0.0.0/16"
}

variable "vpc_public_subnet_count" {
  type        = number
  description = "Number of public subnets to create"
  default     = 2
}

variable "enable_dns_hostnames" {
  type        = bool
  description = "Should enable DNS hostnames"
  default     = true
}

variable "vpc_public_subnets_cidr_block" {
  type        = list(string)
  description = "CIDR block for public subnets in VPC"
  default     = ["10.0.0.0/24", "10.0.1.0/24"]
}

variable "map_public_ip_on_launch" {
  type        = bool
  description = "Should assign an EC2 insance a public IP on launch"
  default     = true
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type"
  default     = "t2.micro"
}

variable "instance_count" {
  type        = number
  description = "Number of EC2 instances to create"
  default     = 2
}

variable "company" {
  type        = string
  description = "A company name to use as a common tag"
  default     = "JCorp"
}

variable "project" {
  type        = string
  description = "A project name to use as a common tag"
}

variable "billing_code" {
  type        = string
  description = "A billing code to use as a common tag"
}

variable "naming_prefix" {
  type        = string
  description = "Naming prefix for all resources"
  default     = "jcorp-web-app"
}

variable "environment" {
  type        = string
  description = "Environment for the resources"
  default     = "dev"
}