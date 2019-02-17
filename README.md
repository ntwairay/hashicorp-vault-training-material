# Scenario
**Customer Background**
Malcolm is a newly appointed VP of engineering and his first project is updating their infrastructure with the ability to scale for events such as black friday. Reese is a lead architect who will be deploying and using Vault. He has good development skills but is not well educated about security concepts like encryption and TLS. They are curious as to how to consolidate multiple sources of authentication within their organization.

**Assignment**
Use Terraform OSS to provision two Vault clusters in two regions in AWS with performance replication. Ensure TLS is enabled on Vault. Provision a transit secret engine key and demonstrate how to encrypt data via the Vault API.

**Stretch Goals**
Demonstrate usage of Vault Identity with username & password and a GitHub token both allowing access to a single static secret path in Vault.

# Prerequisite for this scenario

## AWS Pre Foundation

> To hold terraform remote state

- S3 Buckets

## Minimum AWS Foundation in each region
>> This minimum requirement is used for testing purpose only, therefore its security setting is not completely secured. If you would like to deploy it into a production environment then you will have to reconfigure the NACL and security groups

- VPC
- two public subnets and two private subnets
- three Availability Zone per subnets
- two route tables
- one Internet Gateway
- three Nat Gateways for each zone
- one basic NACL
- one basic security group
- one basion in public subnet
- VPC peering

## Coding structure

> Build ubuntu or linux AMI with consul and vault installed
```
├── packer
│   ├── vault-consul-ami
```

> Build the basic AWS environment

- aws-ad               ***(build aws simple AD)***
- aws-foundation       ***(build the basic AWS Foundation)***
- aws-vpcpeering       ***(build aws peering between two vpcs)***
- aws-vpcpeering-route ***(configure route to the peering network)***
- private-tls          ***(generate self signed ssl certificate before baking an AMI)***
- vault-auto-unseal    ***(build an vault cluster with using kms for auto unseal)***

```
├── terrafrom
│   ├── aws-ad
│   ├── aws-foundation
│   ├── aws-vpcpeering
│   ├── aws-vpcpeering-route
│   ├── private_tls
│   ├── vault-auto-unseal
```

> Contain the example values in tfvars file to be used by terraform
```
├── environment
│   ├── example
│        ├── private_tls
│        ├── us-west-1
│        ├── us-west-2
```
