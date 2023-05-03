# Cloud Run with IAP
Simple Cloud Run deployment using Terraform, CloudBuild, Artifact Registry and protected with IAP

Source for HTTP(S) Load Balancer with Cloud Run: [https://cloud.google.com/load-balancing/docs/https/ext-http-lb-tf-module-examples#with_a_backend](https://cloud.google.com/load-balancing/docs/https/ext-http-lb-tf-module-examples#with_a_backend)


## Overall architecture

![](imgs/0.png)


## Project structure
```
.
|-- app (web application based on nginx)
|   |-- Dockerfile
|   `-- index.html
|-- run-iap (terraform module for LB + IAP + CloudRun)
|   |-- cloudrun.tf
|   |-- iam.tf
|   |-- network.tf
|   `-- vars.tf
|-- README.md
|-- cloudbuild.yaml (build sequence for Cloud Build)
|-- cloudrun.tf (custom module import and definition)
|-- config.tf (services and provider configuration)
|-- deploy.sh (deploy script using gcloud command for docker image "app")
|-- gcr.tf (managed artifact repository)
|-- install.sh (install script for gcp api using gcloud command)
|-- terraform.tfvars.json  (local env variables for terraform)
`-- vars.tf (variables configuration)

```

## Setup

1. Find out your GCP project's id and number from the dashboard in the cloud console, and run the following commands in a terminal at the root of source code (replace `your_project_number`, `your_project_id` and `your_project_region` by the correct values). The `your_iap_email` needs be part of your organisation, and in this example is both the support email for the IAP brand and the user allowed to access the Cloud Run prod service. Create an A record under your Cloud DNS and use this as `your_domain`.
```shell
find . -type f -not -path '*/\.*' -exec sed -i 's/YOUR_PROJECT_NMR/your_project_number/g' {} +
find . -type f -not -path '*/\.*' -exec sed -i 's/YOUR_PROJECT_ID/your_project_id/g' {} +
find . -type f -not -path '*/\.*' -exec sed -i 's/YOUR_PROJECT_REGION/your_project_region/g' {} +
find . -type f -not -path '*/\.*' -exec sed -i 's/YOUR_IAP_SUPPORT_EMAIL/your_iap_email/g' {} +
find . -type f -not -path '*/\.*' -exec sed -i 's/DOMAIN/YOUR_DOMAIN/g' {} +
```

## Install

1. Run the following command at the root of the folder:
```shell 
$ sudo ./install.sh
$ terraform init
$ terraform plan
$ terraform apply
```

> Note: You may have to run `terraform plan` and `terraform apply` twice if you get errors for serviceaccounts not found

2. Build and deploy the docker image in CloudRun service, by issuing the following command at the root of the project:

```shell
$ ./deploy.sh
```
