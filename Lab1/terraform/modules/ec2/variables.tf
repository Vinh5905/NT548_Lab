
variable "instance_name" {
  description = "Name of the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "subnet_id" {
  description = "Subnet ID for EC2 deployment"
  type        = string
}

variable "security_group_ids" {
  description = "List of Security Group IDs"
  type        = list(string)
}

variable "key_name" {
  description = "SSH Key Pair name"
  type        = string
}

variable "associate_public_ip_address" {
  description = "Whether to assign a public IP"
  type        = bool
  default     = false
}
