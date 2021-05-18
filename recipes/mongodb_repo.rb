#
# Cookbook Name:: mongodb
# Recipe:: mongodb_repo
#
# Copyright:: N/A
#

case node[:platform]
when "centos","redhat"
	template "/etc/yum.repos.d/mongodb_repo" do
	  source "mongodb_repo.erb"
	  owner "root"
	  group "root"
	  mode "0644"
	end

	execute "refresh repos" do
	  command "yum clean all"
	end
end
