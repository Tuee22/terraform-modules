
# Vendor-Agnostic Terraform Modules for AWS and GCP

This project provides vendor-agnostic Terraform modules that allow you to provision infrastructure on both AWS and GCP with a consistent interface. It includes two main modules:
- A generic **VPC module** with specific implementations for AWS and GCP.
- A generic **VM module** that depends on the VPC and provisions virtual machines in the appropriate cloud provider.

## Structure

```
terraform/
├── main.tf                    # Root module entry point
├── variables.tf               # Variables for the root module
├── outputs.tf                 # Outputs for the root module
├── modules/                   # Directory for reusable modules
│   ├── vpc/                   # Generic VPC module
│   │   ├── aws/               # AWS-specific VPC implementation
│   │   ├── gcp/               # GCP-specific VPC implementation
│   ├── vm/                    # Generic VM module
│   │   ├── aws/               # AWS-specific VM implementation
│   │   ├── gcp/               # GCP-specific VM implementation
```

## Usage

### Provisioning a VM in AWS:

```bash
terraform apply -var="cloud_provider=aws" -var="cidr_block=10.0.0.0/16" -var="subnet_cidrs=["10.0.1.0/24"]" -var="vm_name=my-aws-vm"
```

### Provisioning a VM in GCP:

```bash
terraform apply -var="cloud_provider=gcp" -var="cidr_block=10.0.0.0/16" -var="subnet_cidrs=["10.0.1.0/24"]" -var="vm_name=my-gcp-vm"
```

## Customization

You can customize the instance types, regions, and other variables in the `variables.tf` file or by passing them in through the command line.

- `instance_type`: The type of VM to provision in AWS (default: `t2.micro`).
- `machine_type`: The type of VM to provision in GCP (default: `e2-medium`).
- `cidr_block`: The CIDR block for the VPC.
- `subnet_cidrs`: The CIDR blocks for the subnets within the VPC.
- `vm_name`: The name of the VM to create.

## Modules

### VPC Module

The VPC module abstracts the creation of a virtual private cloud in both AWS and GCP. Based on the `cloud_provider` variable, it will provision the appropriate resources.

### VM Module

The VM module provisions a virtual machine in the cloud provider specified. It requires the VPC module to be run first and passes the VPC ID as an input.

