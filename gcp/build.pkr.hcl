build {
  sources = ["source.googlecompute.server", "source.googlecompute.client"]


  provisioner "shell" {
    inline = ["echo foo"]
  }

  // why tf these not running

  provisioner "ansible" {
    only          = ["googlecompute.server"]
    playbook_file = "../ansible/nomad-server.yml"
    user          = "packer"
    extra_arguments = [
      "--extra-vars", "ansible_python_interpreter=/usr/bin/python3",
      "--extra-vars", "provision_vault=${var.provision_vault}"
    ]
  }

  provisioner "ansible" {
    only          = ["googlecompute.client"]
    playbook_file = "../ansible/nomad-client.yml"
    user          = "packer"
    extra_arguments = [
      "--extra-vars", "ansible_python_interpreter=/usr/bin/python3",
      "--extra-vars", "provision_vault=${var.provision_vault}"
    ]
  }
}