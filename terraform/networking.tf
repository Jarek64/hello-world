resource "harvester_clusternetwork" "cluster-vlan" {
  name = "test-cluster"
}

resource "harvester_vlanconfig" "cluster-vlan-node1" {
  name = "test-vlan"

  cluster_network_name = harvester_clusternetwork.cluster-vlan.name

  uplink {
    nics = [
        "eno3"
    ]

    bond_mode = "active-backup"
    bond_miimon = 0
  }
}


resource "harvester_network" "test-vlan" {
  name      = "test-vlan"
  namespace = "default"

  vlan_id = 4

  route_mode           = "auto"
  route_dhcp_server_ip = ""

  cluster_network_name = harvester_clusternetwork.cluster-vlan.name
}