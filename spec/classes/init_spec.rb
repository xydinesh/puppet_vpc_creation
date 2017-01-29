require 'spec_helper'
describe 'vpc_creation' do
  context 'with default values for all parameters' do
    it { is_expected.to compile.with_all_deps }
    it { is_expected.to contain_class('vpc_creation') }
  end

  context 'with ec2_vpc creation' do
    it { is_expected.to contain_ec2_vpc('nibiru_vpc').with_region('us-east-2').with_cidr_block('10.0.0.0/16') }
  end

  context 'with ec2_vpc_subnet creation 1' do
    it { is_expected.to contain_ec2_vpc_subnet('nibiru_subnet_1').with_vpc('nibiru_vpc').with_region('us-east-2').with_cidr_block('10.0.1.0/24').with_availability_zone('us-east-2a') }
    it { is_expected.to contain_ec2_vpc_subnet('nibiru_subnet_1').with_route_table('nibiru_routetable_1') }
  end

  context 'with ec2_vpc_subnet creation 2' do
    it { is_expected.to contain_ec2_vpc_subnet('nibiru_subnet_2').with_vpc('nibiru_vpc').with_region('us-east-2').with_cidr_block('10.0.2.0/24').with_availability_zone('us-east-2b') }
    it { is_expected.to contain_ec2_vpc_subnet('nibiru_subnet_2').with_route_table('nibiru_routetable_2') }
  end

  context 'with ec2_vpc_internet_gateway creation' do
    it { is_expected.to contain_ec2_vpc_internet_gateway('nibiru_igw').with_vpc('nibiru_vpc').with_region('us-east-2') }
  end

  context 'with ec2_vpc_routetable creation 1' do
    it { is_expected.to contain_ec2_vpc_routetable('nibiru_routetable_1').with_vpc('nibiru_vpc') }
    it { is_expected.to contain_ec2_vpc_routetable('nibiru_routetable_1').with_routes([
      {
        "destination_cidr_block" => "10.0.0.0/16",
        "gateway"                => "local"
      },{
        "destination_cidr_block"  => "0.0.0.0/0",
        "gateway"                 => "nibiru_igw"
      }]) }
  end

  context 'with ec2_vpc_routetable creation 2' do
    it { is_expected.to contain_ec2_vpc_routetable('nibiru_routetable_2').with_vpc('nibiru_vpc') }
    it { is_expected.to contain_ec2_vpc_routetable('nibiru_routetable_2').with_routes([
      {
        "destination_cidr_block" => "10.0.0.0/16",
        "gateway"                => "local"
      }]) }
  end

end
