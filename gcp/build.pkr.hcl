build {
    sources = ["source.googlecompute.server", "source.googlecompute.client"]

    provisioner "ansible" {
        only = ["source.googlecompute.server"]
        playbook_file = "../ansible/nomad-server.yml"
        user          = "ec2-user"
        extra_arguments = [
            "--extra-vars", "ansible_python_interpreter=/usr/bin/python3"
        ]
    }

    provisioner "ansible" {
        only = ["source.googlecompute.client"]
        playbook_file = "../ansible/nomad-client.yml"
        user          = "ec2-user"
        extra_arguments = [
            "--extra-vars", "ansible_python_interpreter=/usr/bin/python3"
        ]
    }
}