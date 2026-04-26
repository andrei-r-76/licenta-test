variable "test_key_name" {
    type=string
    default="test_key"
}
variable "test_vpc_cidr_block" {
    type=string
    default="192.168.0.0/16"
}
variable "test_ami" {
    type=string
    default="ami-080254318c2d8932f"
}
variable "test_instance_type" {
    type=string
    default="t3.micro"
}
variable "test_runner_name" {
    type=string
    default="Test Runner VM"
}
variable "test_runner_desc" {
    type=string
    default="Creat cu terraform, va fi folosit ca si self hosted runner"
}
variable "test_app_name" {
    type=string
    default="Test App Container VM"
}
variable "test_app_desc" {
    type=string
    default="Creat cu terraform, va fi folosit pentru a rula aplicatia"
}