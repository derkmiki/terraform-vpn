# Terraform AWS Client VPN Certificate

Before running the terraform, do the following to create certificate for the Client VPN. 

This certificate needs to be uploaded to ACM.

Follow these instructions in [Enable mutual authentication for AWS Client VPN](https://docs.aws.amazon.com/vpn/latest/clientvpn-admin/client-auth-mutual-enable.html)

This will upload the cert and key to ACM. 

If the server and client certificates have been issued by the same Certificate Authority (CA), you can use the server certificate ARN for both server and client when you create the Client VPN endpoint.You do not need to upload the client cert.
