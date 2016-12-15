#
# Cookbook Name:: user
# Recipe:: config
#
# Copyright 2011, Hirohide Sano <sanojimaru@gmail.com>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

users = node['user']['accounts']

# only manage the subset of users defined
users.each do |u|
  username = u['username'] || u['id']

  user username do
    %w{username home shell}.each do |attr|
      send(attr, u[attr]) if u[attr]
    end
    action u['action'].to_sym if u['action']
  end

  unless u["authorized_keys"].nil?
    home_dir = u['home'] || "/home/#{username}"
    ssh_dir =  "#{home_dir}/.ssh"
    authorized_keys = "#{ssh_dir}/authorized_keys"

    directory ssh_dir do
      owner username
      mode 0700
      recursive true
      action :create
    end

    file authorized_keys do
      owner username
      mode  0600
      content "#{u['authorized_keys']} #{username}"
    end
  end

  unless u['groups'].nil?
    u['groups'].each do |groupname|
      group groupname do
        members username
        append true
      end
    end
  end
end
