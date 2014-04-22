#
# Cookbook Name:: corsis_create_users
# Recipe:: default
#
# Copyright 2014, Corsis
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

include_recipe "s3_file"

# create accounts, setup authorized_keys
if node.has_key? "corsis_create_users"
    # iterate on groups
    node['corsis_create_users'].each_key do |groupname|
        # need the gid to create the group
        group groupname do
            gid node['corsis_create_users'][groupname]['gid']
            only_if { node['corsis_create_users'][groupname].has_key? "gid" }
        end
        if node['corsis_create_users'][groupname].has_key? "users"
            # iterate on users
            node['corsis_create_users'][groupname]['users'].each_key do |username|
                # need fullname and uid to create the user
                if node['corsis_create_users'][groupname]['users'][username].has_key? "fullname" and node['corsis_create_users'][groupname]['users'][username].has_key? "uid"
                    # create the user
                    user username do
                        comment node['corsis_create_users'][groupname]['users'][username]['fullname']
                        uid node['corsis_create_users'][groupname]['users'][username]['uid']
                        gid groupname
                        home "/home/#{username}"
                        shell "/bin/bash"
                        supports :manage_home=>true
                    end
                    # create the user's .ssh dir
                    directory "/home/#{username}/.ssh" do
                        owner username
                        group groupname
                        mode 00700
                        action :create
                    end
                    # need aws auth info to get the authorized_keys files
                    if node.has_key? "meta-bucket" 
                        # place the user's public key file
                        lfile = "/home/#{username}/.ssh/authorized_keys"
                        rfile = "/common/ssh-public-keys/#{username}.pub"
                        s3_file lfile do
                        	remote_path rfile
                        	bucket node['meta-bucket']
                        	owner username
                         	group groupname
                         	mode "0600"
                        	action :create
                        end
                    end
                end
            end
        end
    end
end
