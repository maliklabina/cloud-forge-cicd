module "dev_infra" {
    source = "./infra-app"
    env    = "dev"
    bucket_name = "infra-app-bucket"
    ec2_ami_id = "ami-0c55b159cbfafe1f0"   
    instance_type = "t3.micro"
    instance_count = 1
    hash_key = "studentID"


}


module "prod_infra" {
    source = "./infra-app"
    env    = "prod"
    bucket_name = "infra-app-bucket"
    ec2_ami_id = "ami-0c55b159cbfafe1f0"   
    instance_type = "t3.micro"
    instance_count = 2
    hash_key = "studentID"

}

# Terraform Steps
# 1 - terraform init
# 2 - terraform plan
# 3 - terraform apply
# 4 - terraform destroy dev module only: terraform destroy -target=module.dev-infra

