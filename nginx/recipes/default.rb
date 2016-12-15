#
# Cookbook Name:: nginx
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package "nginx" do
    action :install
end

directory "/etc/nginx/sites-available" do
  mode 0755
  owner 'root'
  group 'root'
  recursive true
  action :create
end

directory "/etc/nginx/sites-enabled" do
  mode 0755
  owner 'root'
  group 'root'
  recursive true
  action :create
end

template "/usr/sbin/nxensite" do
    source "nxensite.erb"
    owner "root"
    group "root"
    mode 0755
end

template "/usr/sbin/nxdissite" do
    source "nxdissite.erb"
    owner "root"
    group "root"
    mode 0755
end

template "/etc/nginx/nginx.conf" do
    source "nginx.conf.erb"
    owner "root"
    group "root"
    mode 0644
end

service "nginx" do
    action [:enable, :start]
end
