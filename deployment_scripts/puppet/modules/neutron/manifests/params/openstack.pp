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

class neutron::params::openstack {
  $fgt_hash                    = hiera('fuel-plugin-fortinet')

  $networking_fortinet_version = '1.1.3'

  if($::osfamily == 'Redhat') {
    $fwaas_package      = 'python-neutron-fwaas'
    $dashboard_service  = 'httpd'
    $dashboard_settings = '/etc/openstack-dashboard/local_settings'

  } elsif($::osfamily == 'Debian') {

    $fwaas_package      = 'python-neutron-fwaas'
    $dashboard_service  = 'apache2'
    $dashboard_settings = '/etc/openstack-dashboard/local_settings.py'

  } else {

    fail("Unsupported osfamily ${::osfamily}")

  }

  $fgt_host_ip                 = $fgt_hash['fortigate_api_ip']
  $fgt_username                = $fgt_hash['fortigate_api_username']
  $fgt_password                = $fgt_hash['fortigate_api_password']
  $fgt_protocol                = $fgt_hash['fortigate_api_protocol']
  $fgt_port                    = $fgt_hash['fortigate_api_port']
  $fgt_int_port                = $fgt_hash['fortigate_tenant_port']
  $fgt_ext_port                = $fgt_hash['fortigate_external_port']
  $fgt_npu                     = $fgt_hash['fortigate_npu_available']
  $fgt_fwaas_enable            = $fgt_hash['fortigate_fwaas_enable']
}
