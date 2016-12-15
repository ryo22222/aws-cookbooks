#
# Cookbook Name:: play
# Recipe:: default
#
# Copyright 2013, sanojimaru
#
# All rights reserved - Do Not Redistribute
#
include_recipe "nginx"
include_recipe "mysql"

archive_file = "#{Chef::Config[:file_cache_path]}/play-#{node[:play][:version]}.zip"
remote_file archive_file do
  source "http://downloads.typesafe.com/play/#{node[:play][:version]}/play-#{node[:play][:version]}.zip"
end

directory node[:play][:install_dir] do
  owner node[:nginx][:user]
  group node[:nginx][:group]
  mode "0755"
  recursive true
  action :create
end

execute "unzip #{archive_file} -d #{node[:play][:install_dir]}" do
  user node[:nginx][:user]
  group node[:nginx][:group]
  action :run
  not_if{ File.exists?(node[:play][:home]) }
end

template "/etc/profile.d/play.sh" do
  source "play.sh.erb"
  mode 0755
  owner "root"
  group "root"
  variables({
    :home => node[:play][:home]
  })
end

template "/etc/init/#{node[:name]}.conf" do
    source "upstart.conf.erb"
    owner "root"
    group "root"
    mode 0755
    variables({
        home: node[:nginx][:document_root],
        user: node[:nginx][:user],
        group: node[:nginx][:group],
    })
end

template "/etc/sudoers.d/play" do
    source "sudoers.erb"
    owner "root"
    group "root"
    mode 0440
    variables({
        user: node[:nginx][:user]
    })
end

template "/etc/nginx/conf.d/play.conf" do
    source "nginx.conf.erb"
    owner "root"
    group "root"
    variables({
        name: node[:name],
        home: node[:nginx][:document_root],
        user: node[:nginx][:user],
        group: node[:nginx][:group],
    })
end

service "nginx" do
    action :reload
end
