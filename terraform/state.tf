terraform {
    backend "s3" {
        bucket="licentatestterraformbucket"
        key="terraform/terraform.tftstate"
        region="eu-north-1"
    }
}