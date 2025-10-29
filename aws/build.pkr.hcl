build {
    sources = ["source.amazon-ebs.server", "source.amazon-ebs.client"]

    provisioner "ansible" {
        only = ["source.amazon-ebs.server"]
        playbook_file = "../ansible/nomad-server.yml"
        user          = "ec2-user"
        extra_arguments = [
            "--extra-vars", "ansible_python_interpreter=/usr/bin/python3"
        ]
    }

    provisioner "ansible" {
        only = ["source.amazon-ebs.client"]
        playbook_file = "../ansible/nomad-client.yml"
        user          = "ec2-user"
        extra_arguments = [
            "--extra-vars", "ansible_python_interpreter=/usr/bin/python3"
        ]
    }
}