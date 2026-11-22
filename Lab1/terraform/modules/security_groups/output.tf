output "public_id" {
  value = aws_security_group.public.id
  depends_on = [
    aws_vpc_security_group_ingress_rule.public_ssh,
    aws_vpc_security_group_egress_rule.ipv4["public"],
  ]
}

output "private_id" {
  value = aws_security_group.private.id
  depends_on = [
    aws_vpc_security_group_ingress_rule.private_ssh,
    aws_vpc_security_group_egress_rule.ipv4["private"],
  ]
}