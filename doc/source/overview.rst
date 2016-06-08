.. _user_overview:

Overview
========

OpenStack Neutron provides networking-as-a-service between interface devices
(e.g., vNICs) managed by other OpenStack services such as Nova (compute).
The FortiGate Connector for OpenStack Neutron enables a FortiGate physical
or virtual appliance to operate as an OpenStack Neutron network node and delivers
the best of both worlds in advanced security and network performance. The combined
solution enables FortiGate, particularly when leveraging high-speed hardware ASIC’s
in physical models, to boost Neutron performance and eliminate security chokepoints,
by leveraging the Modular Layer 2 (ML2) plug-in interface.

Additional Neutron FWaaS (Firewall-as-a-Service) integration further enables
orchestration of FortiGate security policy through OpenStack, in addition to network
and firewall service insertion. The Horizon dashboard provides a single pane-of-glass
to automatically provision security profiles seamlessly with tenant network and firewall
deployment, allowing clouds and data centers to scale elastically without protection gaps.
Firewall rules can further be customized within the Horizon dashboard, and as well as
delegated when empowering tenant self-service.

This Fuel plugin will enable the installation and configuration of FortiGate connector for
OpenStack with Fuel.

.. _plugin_requirements:

Requirements
------------

+----------------------------------+-----------------------------------------------------------------------+
| **Requirement**                  | **Version/Comment**                                                   |
+==================================+=======================================================================+
| Mirantis OpenStack compatility   | 8.0                                                                   |
+----------------------------------+-----------------------------------------------------------------------+
| Distribution Supported           | Ubuntu                                                                |
+----------------------------------+-----------------------------------------------------------------------+
| Hardware Minimum Recommendations | FortiGate: Physical or Virtual appliances with FOS 5.2.3 and up.      |
|                                  | Fuel Server: 4 CPU, 4G RAM, 100GB Disk, 2 NICs(1 mgmt, 1 pxe)         |
|                                  | OpenStack Controller: 8CPU, 8G RAM, 2 NICs(1 mgmt,pxe, 1 public)      |
|                                  | OpenStack Compute: 8CPU, 16G RAM, 1 NIC(1 mgmt,pxe)                   |
+----------------------------------+-----------------------------------------------------------------------+

.. _plugin_limitations:

Limitations
-----------

At the moment, only vlan segmentation is supported for tenant networks in the
FortiGate Connector, so this fuel plugin will only be available when vlan is chosen
as the tenant network type.
