build {
    sources = ["source.amazon-ebs.server", "source.amazon-ebs.client"]

    provisioner "ansible" {
        only = ["amazon-ebs.server"]
        playbook_file = "../ansible/nomad-server.yml"
        user          = build.User
        extra_arguments = [
            "--extra-vars", "ansible_python_interpreter=/usr/bin/python3"
        ]
    }

    provisioner "ansible" {
        only = ["amazon-ebs.client"]
        playbook_file = "../ansible/nomad-client.yml"
        user          = build.User
        extra_arguments = [
            "--extra-vars", "ansible_python_interpreter=/usr/bin/python3"
        ]
    }
}