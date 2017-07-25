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

class neutron::configure_fortigate_ml2 {
  include neutron::params::openstack

  package { 'python-pip':
    ensure => 'installed',
  }

  exec { 'upgrade pip':
    command => 'pip install -U pip',
    path    => '/usr/local/bin/:/usr/bin/:/bin',
    require => Package['python-pip']
  }

  package { 'networking-fortinet':
    ensure   => $neutron::params::openstack::networking_fortinet_version,
    provider => 'pip',
    require  => Exec['upgrade pip'],
    notify   => Service['neutron-server'],
  }

  exec { 'neutron-db-manage upgrade head':
    command => "neutron-db-manage --config-file /etc/neutron/neutron.conf \
--config-file /etc/neutron/plugin.ini upgrade head",
    path    => '/usr/local/bin/:/usr/bin/:/bin',
    notify  => Service['neutron-server'],
    require => Package['networking-fortinet']
  }

  ini_setting { 'neutron.conf service_plugin':
      ensure            => present,
      path              => '/etc/neutron/neutron.conf',
      section           => 'DEFAULT',
      key_val_separator => '=',
      setting           => 'service_plugins',
      value             => 'router_fortinet',
      notify            => Service['neutron-server'],
  }

  ini_setting { 'plugin.ini mechanism_drivers':
      ensure            => present,
      path              => '/etc/neutron/plugin.ini',
      section           => 'ml2',
      key_val_separator => '=',
      setting           => 'mechanism_drivers',
      value             => 'fortinet,openvswitch',
      notify            => Service['neutron-server'],
  }

  ini_setting { 'plugin.ini fgt address':
      ensure            => present,
      path              => '/etc/neutron/plugin.ini',
      section           => 'ml2_fortinet',
      key_val_separator => '=',
      setting           => 'address',
      value             => $neutron::params::openstack::fgt_host_ip,
      notify            => Service['neutron-server'],
  }

  ini_setting { 'plugin.ini fgt username':
      ensure            => present,
      path              => '/etc/neutron/plugin.ini',
      section           => 'ml2_fortinet',
      key_val_separator => '=',
      setting           => 'username',
      value             => $neutron::params::openstack::fgt_username,
      notify            => Service['neutron-server'],
  }

  ini_setting { 'plugin.ini fgt password':
      ensure            => present,
      path              => '/etc/neutron/plugin.ini',
      section           => 'ml2_fortinet',
      key_val_separator => '=',
      setting           => 'password',
      value             => $neutron::params::openstack::fgt_password,
      notify            => Service['neutron-server'],
  }

  ini_setting { 'plugin.ini fgt api protocol':
      ensure            => present,
      path              => '/etc/neutron/plugin.ini',
      section           => 'ml2_fortinet',
      key_val_separator => '=',
      setting           => 'protocol',
      value             => $neutron::params::openstack::fgt_protocol,
      notify            => Service['neutron-server'],
  }

  ini_setting { 'plugin.ini fgt api port':
      ensure            => present,
      path              => '/etc/neutron/plugin.ini',
      section           => 'ml2_fortinet',
      key_val_separator => '=',
      setting           => 'port',
      value             => $neutron::params::openstack::fgt_port,
      notify            => Service['neutron-server'],
  }

  ini_setting { 'plugin.ini fgt internal interface':
      ensure            => present,
      path              => '/etc/neutron/plugin.ini',
      section           => 'ml2_fortinet',
      key_val_separator => '=',
      setting           => 'int_interface',
      value             => $neutron::params::openstack::fgt_int_port,
      notify            => Service['neutron-server'],
  }

  ini_setting { 'plugin.ini fgt external interface':
      ensure            => present,
      path              => '/etc/neutron/plugin.ini',
      section           => 'ml2_fortinet',
      key_val_separator => '=',
      setting           => 'ext_interface',
      value             => $neutron::params::openstack::fgt_ext_port,
      notify            => Service['neutron-server'],
  }

  ini_setting { 'plugin.ini fgt npu availability':
      ensure            => present,
      path              => '/etc/neutron/plugin.ini',
      section           => 'ml2_fortinet',
      key_val_separator => '=',
      setting           => 'npu_available',
      value             => $neutron::params::openstack::fgt_npu,
      notify            => Service['neutron-server'],
  }

  service { 'neutron-server':
      ensure => running,
      enable => true,
  }

}
