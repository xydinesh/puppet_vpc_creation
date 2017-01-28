require 'spec_helper'
describe 'vpc_creation' do
  context 'with default values for all parameters' do
    it { is_expected.to compile.with_all_deps }
    it { is_expected.to contain_class('vpc_creation') }
  end

  context 'with ec2_vpc creation' do
    it { is_expected.to contain_ec2_vpc('nibiru_vpc').with_region('us-east-2').with_cidr_block('10.0.0.0/16') }
  end
end
