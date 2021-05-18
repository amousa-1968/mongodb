# Chef cookbook to install and configure MongoDB

# MongoDB Cookbook
  -- Installs and configures MongoDB basics:
  -- Single MongoDB instance
  -- In this case the package name is mongodb and will be install version 4.4

# Node
This is the physical, virtual or cloud machine to be configured and each should have the client node installed.

# Workstation
The workstation provides an interface for communication between the server and the client nodes. It provides a platform for writing, testing and deploying  the cookbooks. This is where the roles are also defined

# Test Kitchen
This is where the code is validated.

# Chef Knife
Interacts the nodes.

# Requirements #

## Platform ##
The Cookbooks is build for the following platforms:
* CentOS, Red Hat

The Cookbooks is tested on the following platforms:
* CentOS/Rhel 

## Cookbooks ##
To install the coockbook use the following commands:

  -- The recipes specify resources and order of implementation on the defined tasks. 

# attributes are used to override the default settings.
  -- files used to transfer files from specific path to chef-client.
  -- metadata resource defines the node information as described in the client-node.
  
  gem install librarian
    cd chef-repo
    librarian-chef init
    librarian-chef install
    knife cookbook upload mongodb

# Recipes #
Just include the mongodb cookbock in your runlist or server role with the following hash table:

    {
      "run_list": [
        "recipe[mongodb]"
      ]
    }

This will install the java dependencie, the mongodb server if it is required

# Attributes #
* `node['mongodb']['interface']` - "make access network wide, default is "127.0.0.1".
* `node['mongodb']['port']` = database listener port, default is "27017".
* `node['mongodb']['port']` = database listener port, default is "27018".
* `node['mongodb']['nojournal']` = to disable journaling, default is "false".
* `node['mongodb']['logging_verbose']` = enable verbose logging, default is "false".
* `node['mongodb']['logging_cpu']` = enable cpu usage logging, default is "false".
* `node['mongodb']['oplogging']` = configure operation log, default is "0".
* `node['mongodb']['nohttp']` = disable http rest interface, default is "false".

#Usage
Add mongo instance to the node by following:
  -- add a recipe file that sets the attributes listed above
  -- upload your recipe to the server
  -- run chef-client
  
  # Make sure to update both 
    -- .kitchen.yml 
    -- Jenkinsfile setting to include the following:
  
  # Openstack .kitchen.yml
  -- Specify driver:
  - name: openstack
  - openstack_username: 
  - openstack_api_key: 
  - openstack_auth_url: 'https://openstack-int.platform9.net/keystone/v3'
  
  - floating_ip_pool: 'Add Your-ExtNet'
  - openstack_region: 
  - openstack_region_name: 
  - openstack_project_name: 'ChefKitchen'
  - openstack_project_domain_id: default
  - openstack_user_domain_id: default
  - openstack_network_name: 'chef-internal'
  - key_name: <%= ENV['KEY_NAME'] %>
  - network_id: 'Add your network_id provided by openstack'
 
 # platforms:
  - name: centos-7
    driver:
      - image_ref: 'Add the name'
      - server_name: d1-kitchen-centos7-2_Tomcat

# Vagrant .kitchen.yml 
  Specify driver:
  - name: vagrant
  
  # platforms:
    - name: rhel-7.5
    - name: centos-7

suites:
  - name: default
    run_list:
      - recipe[install_apache::default]
  
