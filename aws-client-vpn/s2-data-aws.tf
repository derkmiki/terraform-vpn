data "aws_caller_identity" "current" {}

data "aws_acm_certificate" "server_cert" {
    domain = "server" # make sure to change this accordingly
  tags = {
    Source = "VPN" # make sure to change this accordingly
  }
}

data "aws_acm_certificate" "client_cert" {
    domain = "client1.domain.tld"  # make sure to change this accordingly
  tags = {
    Source = "VPN" # make sure to change this accordingly
  }
}