# Nomad Server Ansible Playbook for Packer

This Ansible playbook installs and configures HashiCorp Nomad on RHEL or CentOS systems as part of a Packer image build process.

## Features

- Installs HashiCorp Nomad from official releases
- Configures Nomad as a server, client, or both
- Creates systemd service for automatic startup (enabled but not started)
- Configures firewall rules (if firewalld is enabled)
- Prepares image for cluster bootstrapping
- Enables Nomad UI
- Configures Prometheus metrics

## Prerequisites

- RHEL 7/8/9 or CentOS 7/8/9 base image
- Packer 1.7+ with Ansible provisioner
- Ansible 2.9 or higher installed on the build machine

## Variables

Edit the variables in `nomad-server.yml` or create a separate vars file:

| Variable | Default | Description |
|----------|---------|-------------|
| `nomad_version` | `1.8.4` | Nomad version to install |
| `nomad_datacenter` | `dc1` | Datacenter name |
| `nomad_region` | `global` | Region name |
| `nomad_node_role` | `server` | Node role: `server`, `client`, or `both` |
| `nomad_bootstrap_expect` | `3` | Number of servers for cluster bootstrap |

## Usage with Packer

### Packer Template (HCL2)

```hcl
# In your build.pkr.hcl file
build {
  sources = ["source.amazon-ebs.rhel"]

  provisioner "ansible" {
    playbook_file = "./ansible/nomad-server.yml"
    extra_arguments = [
      "-e", "nomad_version=1.8.4",
      "-e", "nomad_node_role=server",
      "-e", "nomad_datacenter=us-east-1"
    ]
  }
}
```

### Building Server Image

```bash
packer build -var 'nomad_role=server' rhel/build.pkr.hcl
```

### Building Client Image

```bash
packer build -var 'nomad_role=client' rhel/build.pkr.hcl
```

## Standalone Testing (Optional)

If you want to test the playbook outside of Packer:

```bash
# Test locally
ansible-playbook nomad-server.yml --connection=local

# Test on remote host
ansible-playbook -i "server.example.com," nomad-server.yml
```

## Post-Installation

After launching an instance from the built AMI/image:

### First Boot Configuration

The Nomad service is enabled but not started. On first boot, you may want to:

1. **Configure instance-specific settings** via user-data or cloud-init:
   ```bash
   # Add encryption key
   cat << EOF > /etc/nomad.d/encryption.hcl
   server {
     encrypt = "your-gossip-encryption-key"
   }
   EOF
   
   # Start Nomad
   systemctl start nomad
   ```

2. **Or start Nomad immediately** (using default config):
   ```bash
   systemctl start nomad
   ```

### Check Nomad Status

```bash
nomad status
nomad server members
nomad node status
```

### Access Nomad UI

Open browser to: `http://<server-ip>:4646`

## Image Customization

The playbook installs Nomad but leaves certain runtime configurations to be set when the instance launches:

- **Gossip encryption key**: Should be added via additional config file
- **Specific cluster join addresses**: Can be configured via cloud provider tags or DNS
- **ACL bootstrap**: Should be done after cluster formation

## Firewall Ports

The playbook automatically configures these ports if firewalld is running:

- **4646/tcp**: HTTP API
- **4647/tcp**: RPC
- **4648/tcp+udp**: Serf WAN (gossip protocol)

## Directory Structure

```
/etc/nomad.d/           # Configuration directory
/opt/nomad/             # Data directory
/usr/local/bin/nomad    # Nomad binary
```

## Service Management

```bash
# Start Nomad
sudo systemctl start nomad

# Stop Nomad
sudo systemctl stop nomad

# Restart Nomad
sudo systemctl restart nomad

# Check status
sudo systemctl status nomad

# View logs
sudo journalctl -u nomad -f
```

## Troubleshooting

### Check Nomad logs

```bash
sudo journalctl -u nomad -n 100 --no-pager
```

### Verify configuration

```bash
nomad agent -config=/etc/nomad.d/nomad.hcl -dev-connect=false -dry-run
```

### Test connectivity

```bash
curl http://localhost:4646/v1/status/leader
```

## Security Notes

1. **Gossip Encryption**: Configure encryption keys at instance launch time, not in the base image
2. **ACLs**: Enable ACLs after cluster formation for production environments
3. **TLS**: Consider enabling TLS for production deployments
4. **Firewall**: The playbook configures basic firewall rules; adjust as needed for your environment
5. **Secrets**: Never bake secrets into AMI/images; use cloud provider secret managers or Vault

## Integration Examples

### AWS User Data Example

```bash
#!/bin/bash
# Add gossip encryption
cat << 'EOF' > /etc/nomad.d/encryption.hcl
server {
  encrypt = "${NOMAD_GOSSIP_KEY}"
}
EOF

# Start Nomad
systemctl start nomad
```

### Cloud-Init Example

```yaml
#cloud-config
write_files:
  - path: /etc/nomad.d/encryption.hcl
    content: |
      server {
        encrypt = "your-encryption-key"
      }

runcmd:
  - systemctl start nomad
```

## References

- [Nomad Documentation](https://www.nomadproject.io/docs)
- [Nomad Configuration](https://www.nomadproject.io/docs/configuration)
- [Nomad Production Deployment Guide](https://learn.hashicorp.com/tutorials/nomad/production-deployment-guide-vm-with-consul)
