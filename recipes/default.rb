#
# Cookbook Name:: packer
# Recipe:: default
#
# Copyright (C) 2013 Hadapt, Inc.
#

# Install packages necessary for extracting stuff
include_recipe "ark"

ark 'packer' do
  url "#{node[:packer][:url_base]}/#{node[:packer][:version]}_#{node[:os]}_#{node[:packer][:arch]}.zip"
  version node[:packer][:version]
  checksum node[:packer][:checksum]
  has_binaries ["packer"]
  append_env_path false
  strip_components 0

  action :install
end

link 'packer-to-packer-packer' do
  # Unfortunately, upstream has stopped using a consistent naming scheme. This circumvents
  # a strange case in which 0.7.1 does not contain 'packer', but 'packer-packer'.
  link_type :symbolic
  owner 'root'
  group 'root'

  target_file "/usr/local/packer-#{node[:packer][:version]}/packer"
  to "/usr/local/packer-#{node[:packer][:version]}/packer-packer"

  not_if { ::File.exists?("/usr/local/packer-#{node[:packer][:version]}/packer") }
end
