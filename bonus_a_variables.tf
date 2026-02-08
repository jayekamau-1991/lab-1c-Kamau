variable "enable_vpc_endpoints" {
  description = "Enable VPC endpoints"
  type        = bool
  default     = false
}

variable "subnet_selection" {
  description = "Select the subnet for the EC2 instance"
  type        = string
}

variable "parameter_store_path_prefix" {
  description = "Path prefix for Parameter Store"
  type        = string
}

variable "secrets_manager_secret_name" {
  description = "Name of the Secrets Manager secret"
  type        = string
}

variable "iam_configuration" {
  description = "IAM configuration for EC2 instance"
  type        = map(string)
}