# Class: aim_client
#
# This module installs the CyberArk AIM client
#

class aim_client (
  $installpackage = $::aim_client::params::installpackage,
  $packageensure  = 'present',
  $password       = passfunc(default),
  $packagesource  = 'puppet:///modules/aim_client',
  $installtarget  = $::aim_client::params::installtarge,
) inherits ::aim_client::params {

  package { "$installpackage":
    ensure => $packageensure,
    source => "$packagesource/$installpackage",
  }

  transition { 'Download Package':
    resource   => File["$installtarget/$installpackage"],
    attributes => { ensure => file,
                    source => "$packagesource/$installpackage",
                    mode   => '0755',
                  },
    prior_to   => Package["$installpackage"],
  }

  transition { 'Stage Password File':
    resource   => File["$installtarget/password.cfg"]
    attributes => { ensure  => file,
                    content => CreatePassConfig($password),
                    mode    => '0644'
    prior_to   => Package["$installpackage"],

  file { ["$installtarget/$installpackage","$installtarget/password.cfg"]:
    ensure => absent,
  }
}


