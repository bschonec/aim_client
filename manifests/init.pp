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

  if $packagesource == 'repo' {
    package { "$installpackage":
      ensure => $packageensure,
    }
  else {
    package { "$installpackage":
      ensure => $packageensure,
      source => "$packagesource/$installpackage",
    }
  }

# Instead of putting the source to use the puppet server as I did above,
# we could also use the transition module here
#
#  transition { 'Download Package':
#    resource   => File["$installtarget/$installpackage"],
#    attributes => { ensure => file,
#                    source => "$packagesource/$installpackage",
#                    mode   => '0755',
#                  },
#    prior_to   => Package["$installpackage"],
#  }

  transition { 'Stage Password File':
    resource   => File["$installtarget/password.cfg"]
    attributes => { ensure  => file,
                    content => CreatePassConfig($password),
                    mode    => '0644'
    prior_to   => Package["$installpackage"],

  file { "$installtarget/password.cfg":
    ensure => absent,
  }
# If I was using the transition module for the package too, I'd want to
# include the lines below instead of the lines above
#
#  file { ["$installtarget/$installpackage","$installtarget/password.cfg"]:
#    ensure => absent,
#  }
}


