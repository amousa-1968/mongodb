#
# Cookbook Name:: mongodb
# Recipe:: install
#
# Copyright:: N/A
#

group node[:mongodb][:group] do
  action [ :create, :manage ]
end

user node[:mongodb][:user] do
  comment "MongoDB Server"
  gid node[:mongodb][:group]
  supports :manage_home => true
  home "/home/#{node[:mongodb][:user]}"
  action [ :create, :manage ]
end

case node[:platform]
when "centos","redhat"
  # use the mongodb_repo
  include_recipe "mongodb::mongodb_repo"
  package "mongodb-enterprise-server-4.4.6"
end

  bash "install-mongodb" do
    cwd "/tmp"
    code <<-EOH
    tar zxvf #{node[:mongodb][:file_name]}.tgz
    mkdir -p #{node[:mongodb][:binaries]}
    mv #{node[:mongodb][:file_name]}/bin/* #{node[:mongodb][:binaries]}
    chmod 755 #{node[:mongodb][:binaries]}
    EOH
    not_if { ::File.exists?("#{node[:mongodb][:binaries]}/mongod") && `mongo --version` != "MongoDB shell version: #{node[:mongodb][:version]}"}
    # not_if { ::File.exists?("#{node[:mongodb][:binaries]}/mongod") }
  end
end

# Add bin directory to everyone's path for bash
template "/etc/profile.d/mongodb.sh" do
  source "mongo.sh.erb"
  owner "root"
  group "root"
  mode 0755
end

# Add bin directory to everyone's path for csh
template "/etc/profile.d/mongodb.csh" do
  source "mongo.csh.erb"
  owner "root"
  group "root"
  mode 0755
end
