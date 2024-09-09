#!/bin/bash

# Function to provision the AWS VPC
provision_aws_vpc() {
  echo "Provisioning AWS VPC..."
  cd terraform/aws || exit
  terraform init
  terraform apply -auto-approve
  cd - || exit
}

# Function to provision the GCP VPC
provision_gcp_vpc() {
  echo "Provisioning GCP VPC..."
  cd terraform/gcp || exit
  terraform init
  terraform apply -auto-approve
  cd - || exit
}

# Function to build Packer images for AWS
build_aws_images() {
  echo "Building AWS images..."
  cd packer/aws || exit
  packer init .
  packer build aws-arm.pkr.hcl &
  packer build aws-x86.pkr.hcl &
  wait # Wait for both builds to finish
  cd - || exit
}

# Function to build Packer images for GCP
build_gcp_images() {
  echo "Building GCP images..."
  cd packer/gcp || exit
  packer init .
  packer build gcp-arm.pkr.hcl &
  packer build gcp-x86.pkr.hcl &
  wait # Wait for both builds to finish
  cd - || exit
}

# Function to clean up the AWS infrastructure
cleanup_aws() {
  echo "Cleaning up AWS infrastructure..."
  cd terraform/aws || exit
  terraform destroy -auto-approve
  cd - || exit
}

# Function to clean up the GCP infrastructure
cleanup_gcp() {
  echo "Cleaning up GCP infrastructure..."
  cd terraform/gcp || exit
  terraform destroy -auto-approve
  cd - || exit
}

# Start AWS VPC provisioning and, once done, start AWS image builds
(provision_aws_vpc && build_aws_images && cleanup_aws) &

# Start GCP VPC provisioning and, once done, start GCP image builds
(provision_gcp_vpc && build_gcp_images && cleanup_gcp) &

# Wait for both AWS and GCP processes to complete
wait

echo "All operations completed successfully."
