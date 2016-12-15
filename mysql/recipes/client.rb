#
# Cookbook Name:: mysql
# Recipe:: client
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

%w(mysql55 mysql55-devel mysql55-libs mysql-connector-java).each do |pkg|
    package pkg do
        action :install
    end
end
