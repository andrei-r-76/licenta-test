output "test_ec2_ips" {
    value = {
        runner=aws_instance.licenta_test_VMRunner.public_ip
        app=aws_instance.licenta_test_VMapp.public_ip
    }
}