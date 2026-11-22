
resource "aws_security_group" "public" {
  name        = "nt548-lab1-public-ec2-sg"
  description = "SSH access to the public EC2"
  vpc_id      = var.vpc_id
}

resource "aws_security_group" "private" {
  name        = "nt548-lab1-private-ec2-sg"
  description = "SSH access from the public EC2"
  vpc_id      = var.vpc_id
}

resource "aws_vpc_security_group_ingress_rule" "public_ssh" {
  security_group_id = aws_security_group.public.id
  cidr_ipv4         = var.ssh_allowed_cidr
  ip_protocol       = "tcp"
  from_port         = 22
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "private_ssh" {
  security_group_id            = aws_security_group.private.id
  referenced_security_group_id = aws_security_group.public.id
  ip_protocol                  = "tcp"
  from_port                    = 22
  to_port                      = 22
}

resource "aws_vpc_security_group_egress_rule" "ipv4" {
  for_each = {
    public  = aws_security_group.public.id
    private = aws_security_group.private.id
  }

  security_group_id = each.value
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

