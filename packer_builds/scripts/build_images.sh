#!/bin/bash
# Step 1: Provision AWS and GCP infrastructure with Terraform
echo "Provisioning AWS infrastructure..."
cd ../terraform/aws
terraform init
terraform apply -auto-approve

echo "Provisioning GCP infrastructure..."
cd ../gcp
terraform init
terraform apply -auto-approve

# Step 2: Build AWS Images with Packer (x86 and ARM)
echo "Building AWS x86 image with Packer..."
packer build   -var "subnet_id=$(terraform output -raw subnet_ids)"   -var "security_group_id=$(terraform output -raw security_group_id)"   -var "key_name=my-key"   ../packer/aws/aws-x86.pkr.hcl

echo "Building AWS ARM image with Packer..."
packer build   -var "subnet_id=$(terraform output -raw subnet_ids)"   -var "security_group_id=$(terraform output -raw security_group_id)"   -var "key_name=my-key"   ../packer/aws/aws-arm.pkr.hcl

# Step 3: Build GCP Images with Packer (x86 and ARM)
echo "Building GCP x86 image with Packer..."
packer build   -var "subnet_id=$(terraform output -raw subnet_ids)"   ../packer/gcp/gcp-x86.pkr.hcl

echo "Building GCP ARM image with Packer..."
packer build   -var "subnet_id=$(terraform output -raw subnet_ids)"   ../packer/gcp/gcp-arm.pkr.hcl
