# AWS — How to build

## Prerequisites
- Reference the main README for general prerequisites: [README.MD](../README.MD)
- AWS VPC with public subnets and internet access (NAT Gateway or Internet Gateway)
- AWS IAM User with permissions to create AMIs, EC2 instances, and related resources

## Authentication

Simplest method is to set environment variables:

```bash
export AWS_ACCESS_KEY_ID=YOUR_KEY
export AWS_SECRET_ACCESS_KEY=YOUR_SECRET
export AWS_DEFAULT_REGION=Your_Region
```

For additional authentication methods, refer to the [Amazon documentation](https://developer.hashicorp.com/packer/integrations/hashicorp/amazon#authentication). 

## Common variables
You may need to provide region, instance type, source AMI, or other vars.


## Validate and build
From this directory (where the Packer template lives):

```bash
packer init .
packer validate .
packer build -var-file=vars.pkrvars.hcl .
```
