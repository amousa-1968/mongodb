#
# Author:: ayman-mousa
# Cookbook Name:: mongodb
# Attribute:: default
# Copyright:: N/A
#

# SERVER CONFIG
case node['platform']                                                                         
when "centos","redhat"
set_unless[:mongodb][:user]  = "mongodb"
set_unless[:mongodb][:group] = "mongodb"
set_unless['mongodb']['path_data'] = "/var/lib/mongo"
set_unless['mongodb']['path_log'] = "/var/log/mongo/mongod.log"
end

set_unless['mongodb']['interface'] = "127.0.0.1"
set_unless['mongodb']['port'] = 27017
set_unless['mongodb']['nojournal'] = false
set_unless['mongodb']['logging_verbose'] = false
set_unless['mongodb']['logging_cpu'] = false
set_unless['mongodb']['oplogging'] = 0
set_unless['mongodb']['nohttp'] = false

set_unless[:mongodb][:version]   = '4.4.6'
set_unless[:mongodb][:file_name] = "mongodb-linux-#{kernel[:machine] || 'i686'}-#{mongodb[:version]}"
set_unless[:mongodb][:url]       = "https://www.mongodb.com/download-center/enterprise/releases/#{mongodb[:file_name]}.tgz"

case node[:platform]
when "centos","redhat"
  # installed from rpm
  set_unless[:mongodb][:binaries]       = "/usr/bin"
end

set_unless[:mongodb][:data_dir]   = "/var/lib/mongodb"
set_unless[:mongodb][:backup_dir] = "/var/lib/mongodb_backups"
set_unless[:mongodb][:log_dir]    = "/var/log/mongodb"
set_unless[:mongodb][:config_dir] = "/etc/mongodb"
set_unless[:mongodb][:pid_dir]    = "/var/run"

set_unless[:mongodb][:run_backups] = false
set_unless[:mongodb][:rest]        = false

set_unless[:mongodb][:mongods] = []
