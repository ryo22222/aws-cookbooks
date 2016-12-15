#
# Cookbook Name:: base
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

execute "Development tools" do
  command 'yum -y groupinstall "Development tools"'
  action :run
end

execute "Update packages" do
    command 'yum -y update'
    action :run
end
