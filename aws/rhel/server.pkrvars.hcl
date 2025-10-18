# Nomad Server Configuration
datacenter = "{{ nomad_datacenter }}"
region     = "{{ nomad_region }}"
data_dir   = "{{ nomad_data_dir }}"

bind_addr = "0.0.0.0"

ui {
  enabled = true
}

acl {
  enabled = false
}

if {{ nomad_enterprise }} {
  audit {
    enabled            = true

    sink "audit" {
    type               = "file"
    delivery_guarantee = "enforced"
    format             = "json"
    path               = "{{ nomad_audit_log_dir }}/audit.log"
    rotate_bytes       = 1000000000  # 1 GB 
    rotate_duration    = "24h"
    rotate_max_files   = 10
    mode               = "0600"
  }

}}


advertise {
  http = "{{ ansible_default_ipv4.address }}"
  rpc  = "{{ ansible_default_ipv4.address }}"
  serf = "{{ ansible_default_ipv4.address }}"
}

server {
  enabled          = true
  bootstrap_expect = {{ nomad_bootstrap_expect }}
  
  # Encryption key should be configured via additional config file at runtime
  # encrypt = "your-key-here"
  
  server_join {
    retry_join = ["provider={{ nomad_cloud_provider }} tag_key=nomad_cluster tag_value={{ nomad_datacenter }}"]
  }
}

telemetry {
  collection_interval        = "1s"
  disable_hostname           = true
  prometheus_metrics         = true
  publish_allocation_metrics = true
  publish_node_metrics       = true
}

