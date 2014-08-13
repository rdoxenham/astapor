class quickstack::pacemaker::stonith::vmware (
  $ipaddr          = "10.10.10.1",
  $login           = "",
  $password        = "",
  $ensure          = "present",
  $powerwait       = '60',
  $vmname          = "",
  ) {

  if($ensure == absent) {
    exec { "Removing stonith::vmware":
      command => "/usr/sbin/pcs stonith delete stonith-vmware-${vmname}",
      onlyif  => "/usr/sbin/pcs stonith show stonith-vmware-${vmname} > /dev/null 2>&1",
      require => Class['pacemaker::corosync'],
    }
  } else {
    package { "fence-agents":
      ensure => installed,
    } ->
    exec { "Creating stonith::vmware":
      command => "/usr/sbin/pcs stonith create stonith-vmware-${vmname} fence_vmware ipaddr=${ipaddr} login=${login} passwd=${password} port=${vmname}",
      unless  => "/usr/sbin/pcs stonith show stonith-vmware-${vmname} > /dev/null 2>&1",
      require => Class['pacemaker::corosync'],
    }
  }
}
