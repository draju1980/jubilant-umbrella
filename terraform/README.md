** To deploy an NGINX node on AWS using Terraform, follow these steps: **

Step 1: Clone this repository https://github.com/draju1980/jubilant-umbrella.git.

Step 2: Navigate to the terraform directory:

```
cd jubilant-umbrella/terraform/
```

Step 3: Verify that Terraform is installed on your local machine:


```
❯ terraform version
Terraform v1.7.4
on darwin_amd64
```


Step 4: Ensure that the AWS CLI is configured:


```
❯ aws configure
AWS Access Key ID [****************7QN5]: 
AWS Secret Access Key [****************GjjH]: 
Default region name [eu-west-1]: 
Default output format [None]: 
```



Step 5: Initialize Terraform:


```
terraform init
```


Step 6: Verify the execution plan before deployment:


```
❯ terraform plan

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create
```


Step 7: Deploy the NGINX node in AWS:


```
❯ terraform apply --auto-approve

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create
```

Step 8: Wait for the deployment to complete. You will receive similar NGINX node information as output:


```
Apply complete! Resources: 10 added, 0 changed, 0 destroyed.

Outputs:

instance_id = "i-08bcf7dce6ccc4847"
nginx_url = "http://54.170.53.222/"
public_ip = "54.170.53.222"
ssh_command = "ssh -i terraform-ssh-key ubuntu@54.170.53.222"
```


Step 9: Verify the NGINX hello world page using curl:


```
❯ curl http://54.170.53.222/
Hello World
```


Step 10: To uninstall all NGINX node components from AWS, use:

```
terraform destroy --auto-approve
```
This will remove all previously deployed NGINX node components from AWS.

With these steps, you can easily deploy and manage NGINX nodes on AWS using Terraform.

--------------------------------------------------------------------------------

For this deployment of the Nginx node, I've organized all the necessary variables, such as AMI, region, and instance type, in the variables.tf file. Similarly, I've configured the output information in the outputs.tf file.

You can easily customize these parameters according to your specific requirements. Here's the folder structure:

```

└── terraform
    ├── README.md
    ├── backend.tf
    ├── main.tf
    ├── outputs.tf
    └── variables.tf

```

In the variables.tf file, you'll find the declarations of variables used in the deployment configuration. Adjust these variables as needed to tailor the deployment to your environment.

In the outputs.tf file, you'll find the configurations for outputting important information after the deployment, such as URLs or IP addresses. Modify these outputs according to the information you need to extract from the deployment.

Feel free to update any other files in the folder to match your requirements. 

--------------------------------------------------------------------------------

Since I'm using local Terraform state, all the state and SSH key files reside in the same directory:

```
└── terraform
    ├── README.md
    ├── main.tf
    ├── outputs.tf
    ├── terraform-ssh-key
    ├── terraform.tfstate
    ├── terraform.tfstate.backup
    └── variables.tf
```

In this structure:

README.md contains documentation or instructions related to the Terraform configuration.
main.tf is the main Terraform configuration file.
variables.tf defines the input variables used in the Terraform configuration.
outputs.tf defines the output values produced by the Terraform configuration.
terraform-ssh-key is the directory containing SSH key files used for authentication.
terraform.tfstate stores the current state of the infrastructure managed by Terraform.
terraform.tfstate.backup is a backup of the previous state file.
This organization ensures that all necessary files for the Terraform project are contained within the same directory for easy management and deployment. Adjustments can be made based on specific project requirements.

--------------------------------------------------------------------------------


To access the Nginx site, use similar nginx_url output link via a web browser.

```
http://54.170.53.222/
```

To SSH onto the NGINX node, use similar ssh_command output in the terminal.

```
ssh -i terraform-ssh-key ubuntu@54.170.53.222
```

This ensures convenient access to both the Nginx site and the NGINX node via their respective outputs.
