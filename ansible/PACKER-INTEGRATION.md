# Integrating Nomad Ansible Playbook with Existing Packer Builds

This guide shows how to integrate the Nomad Ansible playbook with the existing Packer structure.

## Quick Integration

Add the Ansible provisioner to your existing `build.pkr.hcl` files:

### For AWS RHEL Build

Edit `aws/rhel/build.pkr.hcl`:

```hcl
build {
  sources = ["source.amazon-ebs.rhel"]
  
  # ... existing provisioners ...
  
  provisioner "ansible" {
    playbook_file = "../../ansible/nomad-server.yml"
    extra_arguments = [
      "-e", "nomad_version=1.8.4",
      "-e", "nomad_node_role=server",  # or "client" or "both"
      "-e", "nomad_datacenter=us-east-1",
      "--extra-vars", "ansible_python_interpreter=/usr/bin/python3"
    ]
  }
}
```

### For AWS CentOS Build

Edit `aws/centos/build.pkr.hcl`:

```hcl
build {
  sources = ["source.amazon-ebs.centos"]
  
  provisioner "ansible" {
    playbook_file = "../../ansible/nomad-server.yml"
    extra_arguments = [
      "-e", "nomad_version=1.8.4",
      "-e", "nomad_node_role=server",
      "--extra-vars", "ansible_python_interpreter=/usr/bin/python3"
    ]
  }
}
```

### For Azure Builds

Edit `azure/rhel/build.pkr.hcl` or `azure/centos/build.pkr.hcl`:

```hcl
build {
  sources = ["source.azure-arm.rhel"]
  
  provisioner "ansible" {
    playbook_file = "../../ansible/nomad-server.yml"
    extra_arguments = [
      "-e", "nomad_version=1.8.4",
      "-e", "nomad_node_role=server",
      "-e", "nomad_datacenter=eastus",
      "--extra-vars", "ansible_python_interpreter=/usr/bin/python3"
    ]
  }
}
```

### For GCP Builds

Edit `gcp/rhel/build.pkr.hcl` or `gcp/centos/build.pkr.hcl`:

```hcl
build {
  sources = ["source.googlecompute.rhel"]
  
  provisioner "ansible" {
    playbook_file = "../../ansible/nomad-server.yml"
    extra_arguments = [
      "-e", "nomad_version=1.8.4",
      "-e", "nomad_node_role=server",
      "-e", "nomad_datacenter=us-central1"
    ]
  }
}
```

### For IBM Cloud Builds

Edit `ibmcloud/rhel/build.pkr.hcl` or `ibmcloud/centos/build.pkr.hcl`:

```hcl
build {
  sources = ["source.ibmcloud.rhel"]
  
  provisioner "ansible" {
    playbook_file = "../../ansible/nomad-server.yml"
    extra_arguments = [
      "-e", "nomad_version=1.8.4",
      "-e", "nomad_node_role=server",
      "-e", "nomad_datacenter=us-south"
    ]
  }
}
```

## Using Variables

Create a variables file for cleaner configuration:

### Create `ansible-vars.json`

```json
{
  "nomad_version": "1.8.4",
  "nomad_datacenter": "us-east-1",
  "nomad_node_role": "server"
}
```

### Reference in Packer

```hcl
build {
  sources = ["source.amazon-ebs.rhel"]
  
  provisioner "ansible" {
    playbook_file = "../../ansible/nomad-server.yml"
    extra_arguments = [
      "-e", "@ansible-vars.json"
    ]
  }
}
```

## Building Different Node Types

### Server Node

```bash
cd aws/rhel
packer build \
  -var 'nomad_role=server' \
  build.pkr.hcl
```

### Client Node

```bash
cd aws/rhel
packer build \
  -var 'nomad_role=client' \
  build.pkr.hcl
```

### Dual Mode (Server + Client)

```bash
cd aws/rhel
packer build \
  -var 'nomad_role=both' \
  build.pkr.hcl
```

## Python Interpreter Notes

- **RHEL 8/9**: Use `/usr/bin/python3`
- **RHEL 7**: Use `/usr/bin/python` or `/usr/bin/python2`
- **CentOS 8/9**: Use `/usr/bin/python3`
- **CentOS 7**: Use `/usr/bin/python`

If Ansible can't find Python, add a shell provisioner before the Ansible provisioner:

```hcl
provisioner "shell" {
  inline = ["sudo yum install -y python3"]
}
```

## Troubleshooting

### Ansible Connection Issues

If you see connection errors, ensure SSH is ready:

```hcl
provisioner "shell" {
  inline = ["echo 'SSH is ready'"]
}

provisioner "ansible" {
  playbook_file = "../../ansible/nomad-server.yml"
  # ...
}
```

### Python Not Found

Add Python installation:

```hcl
provisioner "shell" {
  inline = [
    "sudo yum update -y",
    "sudo yum install -y python3"
  ]
}
```

### Playbook Path Issues

Use absolute paths or verify relative paths:

```hcl
provisioner "ansible" {
  playbook_file = "${path.root}/../../ansible/nomad-server.yml"
  # ...
}
```

## Complete Example

Here's a complete build block:

```hcl
build {
  name = "nomad-server-rhel"
  sources = ["source.amazon-ebs.rhel"]
  
  # Ensure system is up to date and Python is installed
  provisioner "shell" {
    inline = [
      "sudo yum update -y",
      "sudo yum install -y python3"
    ]
  }
  
  # Install Nomad using Ansible
  provisioner "ansible" {
    playbook_file = "../../ansible/nomad-server.yml"
    extra_arguments = [
      "-e", "nomad_version=1.8.4",
      "-e", "nomad_node_role=server",
      "-e", "nomad_datacenter=${var.datacenter}",
      "--extra-vars", "ansible_python_interpreter=/usr/bin/python3"
    ]
  }
  
  # Cleanup
  provisioner "shell" {
    inline = [
      "sudo yum clean all",
      "sudo rm -rf /tmp/*"
    ]
  }
}
```
