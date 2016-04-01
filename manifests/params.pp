# Class: aim_client::params
#
# This class manages AIM Client parameters
#
# Parameters:
# - The $installpackage for the AIM client
# - The $installtarget for temporarily hosting the configuration file

class aim_client::params {
  case $::operatingsystem {
    'RedHat', 'CentOS'  { $installpackage = 'aimclient.rpm' }
    'Solaris'           { $installpackage = 'solarispackage' }
    'Ubuntu'            { $installpackage = 'aimclient.deb' }
    'Windows'           { $installpackage = 'aimclient.msi' }
  }
  if $::kernel =='Windows' {
    $installtarget = 'C:\\windows\temp'
  }
  else {
    $installtarget = '/tmp'
  }
}
