# encoding: UTF-8

require 'chefspec'
require 'chefspec/berkshelf'

::LOG_LEVEL = :fatal
::SUSE_OPTS = {
  platform: 'suse',
  version: '11.03',
  log_level: ::LOG_LEVEL
}
::REDHAT_OPTS = {
  platform: 'redhat',
  version: '6.5',
  log_level: ::LOG_LEVEL
}
::UBUNTU_OPTS = {
  platform: 'ubuntu',
  version: '12.04',
  log_level: ::LOG_LEVEL
}

shared_context 'database-stubs' do
  before do
    # for redhat
    stub_command("/usr/bin/mysql -u root -e 'show databases;'")
    # for debian
    stub_command("\"/usr/bin/mysql\" -u root -e 'show databases;'")

    ::Chef::Recipe.any_instance.stub(:address_for)
      .with('lo')
      .and_return('127.0.0.1')
  end
end

# README(galstrom21): This will remove any coverage warnings from
#   dependent cookbooks
ChefSpec::Coverage.filters << '*/openstack-ops-database'

at_exit { ChefSpec::Coverage.report! }
