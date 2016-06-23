Installation Guide
==================

How to install Fuel Master
--------------------------

Please refer to `Mirantis official documentation for Fuel 8.0 <https://docs.mirantis.com/openstack/fuel/fuel-8.0/pdfs.html>`_ for the installation of Fuel master node or `this quickstart guide <https://docs.mirantis.com/openstack/fuel/fuel-8.0/quickstart-guide.html#installing-mirantis-openstack-manually>`_ to setup a demo environment.

How to install the plugin
-------------------------

#. Build the fuel plugin on Fuel Master.

   .. code:: bash
       git clone https://github.com/jerryz1982/fuel-plugin-fortinet.git
       cd fuel-plugin-fortinet
       fpb --build ./
       
#. Install the plugin using the fuel command line:

   .. code:: bash
       fuel plugins --install fuel-plugin-fortinet*.rpm

#. Verify that the plugin is installed correctly:

   .. code:: bash

       [root@fuel ~]# fuel plugins
       id | name                 | version | package_version
       ---|----------------------|---------|----------------
       1  | fuel-plugin-fortinet | 1.0.0   | 4.0.0         
