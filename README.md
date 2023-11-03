## Infrastructure as Code GCP-Driven


Infrastructure as code, also referred to as IaC, is an IT practice that codifies and manages underlying IT infrastructure as software. The purpose of infrastructure as code is to enable developers or operations teams to automatically manage, monitor and provision resources, rather than manually configure discrete hardware devices and operating systems. Infrastructure as code is sometimes referred to as programmable or software-defined infrastructure.


# #

[![License](https://img.shields.io/badge/License-UNLISENSED-silver.svg?style=flat)](https://github.com/clips/pattern/blob/master/LICENSE.txt) 
[![License](https://img.shields.io/badge/Terraform-v1.5.0-purple.svg?style=flat)](https://github.com/clips/pattern/blob/master/LICENSE.txt) 
[![License](https://img.shields.io/badge/GCP_CLI-v416.0.0-yellow.svg?style=flat)](https://github.com/clips/pattern/blob/master/LICENSE.txt)
[![License](https://img.shields.io/badge/TerraGrunt-v1.5.0-blue.svg?style=flat)](https://github.com/clips/pattern/blob/master/LICENSE.txt)

# #

# Requirements

- GCLOUD CLI
- Terraform CLI (v1.3.6)


# How to start project

Replace <env> whit your environment.


```sh
$ gcloud auth login
```

```sh
$ terraform init 
```

```sh
$ terraform plan 
```

```sh
$ terraform apply 
```


Get the GKE Context


```sh
gcloud container clusters get-credentials ${CLUSTERNAME} --region ${REGION} --project ${PROJECT_ID}
```