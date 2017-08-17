# Terraform Azure examples

[![MIT License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

Example Terraform code to create basic resources in Azure RM.

## Requirements

* Terraform 0.10 upper or Docker

## Usage

### With Docker
#### Setup

```bash
$ docker run -v ${PWD}/example_usage/terraform/providers/azurerm/us_west_example_prod/:/terraform -w /terraform hashicorp/terraform:full init
```

#### Plan

```bash
$ docker run -v ${PWD}/example_usage/terraform/providers/azurerm/us_west_example_prod/:/terraform -w /terraform hashicorp/terraform:full init
$ docker run -e TF_VAR_client_id -e TF_VAR_client_secret -e TF_VAR_subscription_id -e TF_VAR_tenant_id -v ${PWD}/example_usage/terraform/providers/azurerm/us_west_example_prod/:/terraform -w /terraform hashicorp/terraform:full plan
```

### Without Docker
#### Setup

```bash
$ export TF_VAR_client_id=[your client_id]
$ export TF_VAR_client_secret=[your client_id]
$ export TF_VAR_subscription_id=[your subscription_id]
$ export TF_VAR_tenant_id=[your tenant_id]
$ cd example_usage/terraform/providers/azurerm/us_west_example_prod
$ terraform init
```

#### Plan

```bash
$ terraform plan
```
