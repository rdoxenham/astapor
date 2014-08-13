class quickstack::pacemaker::stonith::ovirt (
  $ipaddr          = "10.10.10.1",
  $ipport          = "8443",
  $login           = "",
  $password        = "",
  $ensure          = "present",
  $ssl             = true,
  $powerwait       = '60',
  $vmname          = "",
  ) {

  if($ensure == absent) {
    exec { "Removing stonith::ovirt":
      command => "/usr/sbin/pcs stonith delete stonith-ovirt-${vmname}",
      onlyif  => "/usr/sbin/pcs stonith show stonith-ovirt-${vmname} > /dev/null 2>&1",
      require => Class['pacemaker::corosync'],
    }
  } else {
    package { "fence-agents":
      ensure => installed,
    } ->
    exec { "Creating stonith::ovirt":
      command => "/usr/sbin/pcs stonith create stonith-ovirt-${vmname} fence_rhevm ipaddr=${ipaddr} login=${login} passwd=${password} port=${vmname} powerwait=${powerwait} ssl=on",
      unless  => "/usr/sbin/pcs stonith show stonith-ovirt-${vmname} > /dev/null 2>&1",
      require => Class['pacemaker::corosync'],
    }
  }
}
