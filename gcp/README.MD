# GCP — How to build

## Prerequisites
- Reference the main README for general prerequisites: [README.MD](../README.MD)  
- Google Cloud Project with a VPC, subnets, and internet access (Cloud NAT or public subnet + Internet Gateway)
- Account with permissions to create images and instances and to write to Cloud Storage 
- Ensure APIs are enabled: Compute Engine, Cloud Storage, IAM
- (Optional) Install and configure the gcloud CLI: https://cloud.google.com/sdk/docs/install


## Credentials
The simplest method is to run this locally, authenticated via gcloud:

```bash
gcloud init
gcloud auth login
gcloud config set project YOUR_PROJECT_ID
gcloud auth application-default login
```

_Note: This will only create a token valid for 1 hour._

For additional authentication methods, refer to the [Google Cloud Platform documentation](https://developer.hashicorp.com/packer/integrations/hashicorp/googlecompute#authentication). 

## Common variables



## Validate and build
From this directory (where the Packer template lives):

```bash
packer init .
packer validate .
packer build -var-file=vars.pkrvars.hcl . 
```
