#
# Cookbook Name:: git
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
pkgs = ["curl-devel","perl-ExtUtils-MakeMaker","zlib-devel","openssl-devel","cpio","expat-devel","gettext-devel","gcc"]

pkgs.each do |pkg|
	package pkg do
		action :install
	end
end	
	

git_version = "2.5.2"
remote_file "/var/tmp/git-#{git_version}.tar.gz" do
	source "https://www.kernel.org/pub/software/scm/git/git-#{git_version}.tar.gz"
	owner 'root'
	group 'root'
	mode '0755'
	action :create
end

bash "extracting and installing git-#{git_version}.tar.gz" do 
	cwd "/var/tmp"
	code <<-EOH
		tar -zxf git-#{git_version}.tar.gz
		cd git-#{git_version}
		./configure --prefix=/usr/local/git
		make
		make install
		ln -s /usr/local/git/bin/git /usr/bin/git 
	EOH
	not_if "/usr/bin/git --version | grep -q '#{git_version}'"
end
