## Overview

This directory contains Ansible playbooks and Jinja2 templates to configure Nomad agents (both servers and clients) during the Packer build process. The playbooks set up the necessary configurations, directories, and services required for Nomad to operate effectively in various cloud environments.

## Directory Structure

```
├── nomad-client.yml
├── nomad-server.yml
├── README.MD
└── templates
    ├── agent
    │   ├── acl.hcl.j2
    │   ├── agent.hcl.j2
    │   ├── audit.hcl.j2
    │   ├── autopilot.hcl.j2
    │   ├── client.hcl.j2
    │   ├── license.hclic.j2
    │   ├── server.hcl.j2
    │   ├── telemetry.hcl.j2
    │   └── tls.hcl.j2
    ├── service
    │   └── nomad.service.j2
    └── task_drivers
        └── podman.yml

5 directories, 14 files
```

## Playbooks
- `nomad-client.yml`: Configures Nomad client agents
- `nomad-server.yml`: Configures Nomad server agents

## Templates
- `templates/agent/`: Contains Jinja2 templates for Nomad agent configuration files
- `templates/service/`: Contains the systemd service file template for Nomad
- `templates/task_drivers/`: Contains task driver configuration templates (e.g., Podman)

## Usage
To use these playbooks, include them in your Packer build process to automate the configuration of Nomad agents on the images being built. Ensure that you have the necessary variables defined for your environment, such as `nomad_user`, `nomad_group`, `nomad_config_dir`, and others as required by the templates.

Refer to the individual playbooks for specific tasks and configurations applied during the provisioning of Nomad agents.