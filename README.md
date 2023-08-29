# AutomationProject

Experience streamlined infrastructure management with our project combining Ansible and Terraform. From partitioning disks to configuring load-balanced websites.
It seamlessly manages user creation, file modifications, provisioning, and post-deployment validation, ensuring a reliable and consistent infrastructure deployment experience.

## To initialize the plugins and backend
`terraform init`

## To confirm there are no typos and syntax errors
`terraform validate`

## Review the entire plan prior to deployment
`terraform plan`

## The entire configuration as code (Ansible) developed will be provisioned flawlessly and non-interactively with the infrastructure as code (Terraform)
`terraform apply --auto-approve`

## To see output
`terraform output`
`terraform state list | nl`


