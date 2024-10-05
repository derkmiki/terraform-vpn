# Terraform AWS Client VPN

This is a simple demonstration of implementing AWS Client VPN via Terraform.

This includes the following resources:

- VPC Components
- NAT Gateway
- Internet Gateway
- EC2
- AWS Client VPN
  
This terraform implementation creates an EC2 in the private subnet inside the VPC. 
The EC2 instance has init-script that adds a basic HTML  file and enables Apache HTTP service.
To access the web server inside the EC2 instance, a client VPN is created. This client VPN uses certificate-based authentication.
I opted to exclude the certificate in Terraform, and instead upload the certificate manually into ACM.

Please see the Readme under aws-client-cert.

To connect to AWS client VPN 

Follow step in [Step 7: Download the Client VPN endpoint configuration file](https://docs.aws.amazon.com/vpn/latest/clientvpn-admin/cvpn-getting-started.html#cvpn-getting-started-connect)

You may want to create more client certificate and add it to specific vpn configuration file you want to distribute to each user.

Licence: MIT