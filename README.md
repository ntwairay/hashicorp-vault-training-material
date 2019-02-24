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
> This minimum requirement is used for testing purpose only, therefore its security setting is not completely secured. If you would like to deploy it into a production environment then you will have to reconfigure the NACL and security groups

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

> AWS environment

- aws-ad               ***(build aws simple AD)***
- aws-foundation       ***(build the basic AWS Foundation such as VPC, Subnets, Internet Gateway and Nat Gateway etc)***
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

## Deployment script

> This is a helper script for deploying the entire demo into your AWS environment using the sample tfvars values in ./environment/exmaple/

```
├── run-tf
```

### Export Environment Variables
```
export AWS_ACCESS_KEY_ID=XXXXXXXXXXXXXXXXX
export AWS_SECRET_ACCESS_KEY=XXXXXXXXXXXXXXXXX
export AWS_DEFAULT_REGION=us-west-1
```

### Deploy demo
> This command will deploy the entire demo infrastructure into two regions us-west-1 and us-west-2
```
sh ./run-tf apply --demo
```

- Create two VPCs, 2 or 3 public subnets, 2 or 3 private subnets, Internet Gateway, Nat Gateway, Security Groups, NACL and Route Tables
- Create vpc peering connection between two VPCs in two regions
- Configure Peering route in the private subnet routing table in two VPCs
- Create Vault and Consul cluster under privates subnets in both VPCs

> This command will destroy the demo
```
sh ./run-tf destroy --demo
```

### Deploy individually
> This helper script also allow to deploy each terraform component individually in multiple regions


### Example
#### Deploy aws-foundation in one region (ap-southeast-1)
```
sh ./run-tf apply --aws-foundation "ap-southeast-1"
```

#### Deploy aws-foundation in two regions (ap-southeast-1 and ap-southeast-2)
```
sh ./run-tf apply --aws-foundation "ap-southeast-1 ap-southeast-2"
```

#### Destroy aws-foundation in one region (ap-southeast-1)
```
sh ./run-tf destroy --aws-foundation "ap-southeast-1"
```

#### Destroy aws-foundation in two regions (ap-southeast-1 and ap-southeast-2)
```
sh ./run-tf destroy --aws-foundation "ap-southeast-1 ap-southeast-2"
```
#### Print_usage
```
sh ./run-tf apply --help

Options:

-e   --aws-foundation [REGION]	Deploy the aws-foundation into your AWS environment
-e   --aws-vpcpeering [REGION]	Create vpc peering connection between two VPCs (Require two AWS VPCs in two different Regions)
-e   --aws-vpcpeering-route [REGION]	Configure the routing table (Require VPC Peering connection)
-e   --vault-kms-cluster [REGION]	Create Vault Cluster under private subnets usign kms for auto unseal
-e   --aws-ad [REGION]	Create a simple AD which can be used in ldap testing
-e   --demo	Deploy the entire demo into your AWS environments
-e   --help	Print usage page
Examples 1:

  run-tf apply --demo

Or

  run-tf apply --aws-foundation 'us-west-1 us-west-2'

```
