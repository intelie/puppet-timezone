# == Class: timezone
#
# Timezone configuration
#
# === Parameters
#
# [*zone*]
#   Timezone name default: 'America/Sao_Paulo'
##
# === Examples
#
#  class { timezone:
#    zone => 'America/Sao_Paulo'
#  }
#
# === Authors
#
# Jorge Falcão <falcao@intelie.com.br>
#
# === Copyright
#
# Copyright 2012 Intelie
#

class timezone($zone = 'America/Sao_Paulo') {
  case $operatingsystem {
    centos, redhat: {
        file { '/etc/sysconfig/clock':
          ensure  => present,
          content => "ZONE='${zone}'",
        } ~> exec { "zic -l ${zone}":
          path        => '/usr/sbin/',
          refreshonly => true
        }
        
        # ~> exec { 'tzdata-update':
          #path        => '/usr/sbin/',
          #refreshonly => true
        #}
    }
    #debian, ubuntu: {
    # TODO
    #}
    default: {
      fail("Module ${module_name} is not supported on ${operatingsystem}")
    }
  }
}
