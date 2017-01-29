require 'rspec-puppet'
require 'puppetlabs_spec_helper/module_spec_helper'
require 'puppetlabs_spec_helper/puppetlabs_spec_helper'

base_path = File.expand_path(File.join(__FILE__, '..', 'fixtures'))
RSpec.configure do |c|
  c.fail_fast = true
  c.formatter = :documentation 
  c.module_path = File.join(base_path, 'modules')
  c.manifest_dir = File.join(base_path, 'manifests')
  c.hiera_config = 'spec/fixtures/hiera.yaml'
end
