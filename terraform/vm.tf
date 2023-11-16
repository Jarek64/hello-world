resource "harvester_virtualmachine" "ubuntu" {
  count     = 1
  name      = "ubuntu-${count.index}"
  namespace = "default"

  
  tags = {
    ssh-user = "ubuntu"
  }

  cpu    = 2
  memory = "4Gi"

  efi         = true
  secure_boot = false

  network_interface {
    name         = "eth0"
    network_name = harvester_network.test-vlan.id
  }

  ssh_keys = [
    harvester_ssh_key.ssh-key.id
  ]
  disk {
    name = "disk-0"
    type = "disk"
    size = "30Gi"
    bus = "virtio"
    boot_order = 1
    image = "default/image-4m7q9"
    auto_delete = true
  }

  cloudinit {
    user_data = <<-EOF
        #cloud-config
        user: ubuntu
        package_update: true
        packages:
            - qemu-guest-agent
        runcmd:
          - - systemctl
            - enable
            - --now
            - qemu-guest-agent.service

        ssh_authorized_keys: 
            - >-
                ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAz3MkPWjNlrkK+2KPlKxnpHSGmm231U0hb+WKC132Paj1EXzLOUurRGMyRXuDm1PyiirQKWny61BHlxRACx8cqjEcP7vmPm0AYu98C1dpTCH6bUTPv4Z+aE4tvwx4JOY5M5M3Oic25XxPGINaS7Pez+fEqYyqeCAngUiUrMV9BbS+mWIAa4ia+VJJxumvl8j2FgW+x5rtQlYLtqNh17trStkBMRPlDucPrqLYkbJvQQicuSFFMSNaO/85fB+VaqS3VWSTVWcvv86u4ZkD9Ld/jLhoBZ/4b03IFKs2YclOMs+IryQf14IyLBklQo762bTfPl9zgMsUH6KbX9hTKtOjgw== akunkee@kronos
    EOF
    network_data = ""
  }



}