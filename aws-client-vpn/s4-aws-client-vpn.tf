resource "aws_ec2_client_vpn_endpoint" "vpn" {
  description       = "VPN endpoint"
  client_cidr_block = "10.1.0.0/16" # make sure this not overlap with vpc 
  split_tunnel      = true
 server_certificate_arn = data.aws_acm_certificate.server_cert.arn
  security_group_ids     = concat([module.private_sg.security_group_id], [aws_security_group.vpn_access.id])
  vpc_id                 = module.vpc.vpc_id

  authentication_options {
    type                       = "certificate-authentication"
    root_certificate_chain_arn = data.aws_acm_certificate.client_cert.arn
  }
  connection_log_options {
    enabled = false
  }
  tags = {
    Name        = "VPN"
    Environment = var.environment
  }
}

resource "aws_security_group" "vpn_access" {
  vpc_id = module.vpc.vpc_id
  name   = "vpn-sg"

  ingress {
    from_port   = 5432
    protocol    = "TCP"
    to_port     = 5432
    cidr_blocks = ["0.0.0.0/0"]
    description = "Incoming Postgres"
  }
  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "VPN"
  }
}

resource "aws_ec2_client_vpn_network_association" "vpn_subnets" {
  count                  = length(module.vpc.private_subnets)
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.vpn.id
  subnet_id              = element(module.vpc.private_subnets, count.index)
  lifecycle {
    // The issue why we are ignoring changes is that on every change
    // terraform screws up most of the vpn assosciations
    // see: https://github.com/hashicorp/terraform-provider-aws/issues/14717
    ignore_changes = [subnet_id]
  }
}


resource "aws_ec2_client_vpn_authorization_rule" "vpn_auth_rule" {
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.vpn.id
  target_network_cidr    = module.vpc.vpc_cidr_block
  authorize_all_groups   = true
}
