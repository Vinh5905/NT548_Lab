variable "aws_region" {
  description = "AWS Region for deployment"
  type        = string
  default     = "ap-southeast-1"
}


variable "ssh_allowed_cidr" {
  description = "Public IP allowed to SSH into Public EC2"
  type        = string
}
