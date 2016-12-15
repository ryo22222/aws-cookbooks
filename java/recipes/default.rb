#
# Cookbook Name:: java
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

%w(java-1.7.0-openjdk java-1.7.0-openjdk-devel).each do |pkg|
  package pkg do
    action :install
  end
end

execute "Update java alternatives" do
  command "update-alternatives --set java /usr/lib/jvm/jre-1.7.0-openjdk.x86_64/bin/java"
  action :run
end

