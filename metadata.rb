name 'openstack-identity'
maintainer 'openstack-chef'
maintainer_email 'openstack-dev@lists.openstack.org'
issues_url 'https://launchpad.net/openstack-chef' if respond_to?(:issues_url)
source_url 'https://github.com/openstack/cookbook-openstack-identity' if respond_to?(:source_url)
license 'Apache 2.0'
description 'The OpenStack Identity service Keystone.'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '15.0.0'

%w(ubuntu redhat centos).each do |os|
  supports os
end

depends 'apache2', '~> 3.2'
depends 'openstack-common', '>= 15.0.0'
depends 'openstackclient'
