terraform {
    backend "s3" {
        bucket="licentatestterraformbucket"
        key="terraform/terraform.tfstate"
        region="eu-north-1"
    }
}