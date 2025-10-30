# AWS — How to build

## Prerequisites
- Reference the main README for general prerequisites: [README.MD](../README.MD)
- AWS VPC with public subnets and internet access (NAT Gateway or Internet Gateway)
- AWS IAM User with permissions to create AMIs, EC2 instances, and related resources

## Credentials
Set AWS credentials in one of these ways:
- Environment variables:
```bash
export AWS_ACCESS_KEY_ID=YOUR_KEY
export AWS_SECRET_ACCESS_KEY=YOUR_SECRET
export AWS_DEFAULT_REGION=Your_Region
```

## Common variables
You may need to provide region, instance type, source AMI, or other vars.


## Validate and build
From this directory (where the Packer template lives):

```bash
packer init .
packer validate .
packer build -var-file=vars.pkrvars.hcl template.pkr.hcl
```
