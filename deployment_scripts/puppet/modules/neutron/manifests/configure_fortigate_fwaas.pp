#
#    Copyright 2016 Fortinet Inc.
#
#    Licensed under the Apache License, Version 2.0 (the "License"); you may
#    not use this file except in compliance with the License. You may obtain
#    a copy of the License at
#
#         http://www.apache.org/licenses/LICENSE-2.0
#
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
#    WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
#    License for the specific language governing permissions and limitations
#    under the License.
#

class neutron::configure_fortigate_fwaas {
  include neutron::params::openstack

  package { 'neutron-fwaas':
    ensure => present,
    name   => $neutron::params::openstack::fwaas_package,
    notify => Service['neutron-server'],
  }

  ini_setting { 'neutron.conf service_plugin':
      ensure            => present,
      path              => '/etc/neutron/neutron.conf',
      section           => 'DEFAULT',
      key_val_separator => '=',
      setting           => 'service_plugins',
      value             => 'router_fortinet,fwaas_fortinet',
      notify            => Service['neutron-server'],
  }

  exec { 'neutron-db-sync':
    command     => 'neutron-db-manage --config-file /etc/neutron/neutron.conf \
--config-file /etc/neutron/plugin.ini --service fwaas upgrade head',
    path        => '/usr/bin',
    require     => Package['neutron-fwaas'],
    notify      => Service['neutron-server'],
  }

  exec { 'enable_fwaas_dashboard':
    command => "/bin/sed -i \"s/'enable_firewall': False/'enable_firewall': True/\" ${neutron::params::openstack::dashboard_settings}",
    unless  => "/bin/egrep \"'enable_firewall': True\" \
${fwaas::params::openstack::dashboard_settings}",
    require => Package['neutron-fwaas'],
    notify  => Service[$neutron::params::openstack::dashboard_service],
  }

  service { 'neutron-server':
    ensure => running,
    enable => true,
  }

  service { $neutron::params::openstack::dashboard_service:
    ensure => running,
    enable => true,
  }
}
