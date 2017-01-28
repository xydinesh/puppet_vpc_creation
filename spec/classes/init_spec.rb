require 'spec_helper'
describe 'vpc_creation' do
  context 'with default values for all parameters' do
    it { should contain_class('vpc_creation') }
  end
end
