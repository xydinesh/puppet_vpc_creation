# Class: vpc_creation
# ===========================
#
# Full description of class vpc_creation here.
#
# Parameters
# ----------
#
# Document parameters here.
#
# * `sample parameter`
# Explanation of what this parameter affects and what it defaults to.
# e.g. "Specify one or more upstream ntp servers as an array."
#
# Variables
# ----------
#
# Here you should define a list of variables that this module would require.
#
# * `sample variable`
#  Explanation of how this variable affects the function of this class and if
#  it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#  External Node Classifier as a comma separated list of hostnames." (Note,
#  global variables should be avoided in favor of class parameters as
#  of Puppet 2.6.)
#
# Examples
# --------
#
# @example
#    class { 'vpc_creation':
#      servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#    }
#
# Authors
# -------
#
# Author Name <author@domain.com>
#
# Copyright
# ---------
#
# Copyright 2017 Your name here, unless otherwise noted.
#
class vpc_creation (
  $region,
  $cidr_block,
){
  ec2_vpc { 'nibiru_vpc':
    ensure     => present,
    region     => $region,
    cidr_block => $cidr_block
  }

  ec2_vpc_subnet { 'nibiru_subnet_1':
    ensure            => present,
    vpc               => 'nibiru_vpc',
    region            => $region,
    cidr_block        => '10.0.1.0/24',
    availability_zone => 'us-east-2a',
    route_table       => 'nibiru_routetable_1',
  }

  ec2_vpc_subnet { 'nibiru_subnet_2':
    ensure            => present,
    vpc               => 'nibiru_vpc',
    region            => $region,
    cidr_block        => '10.0.2.0/24',
    availability_zone => 'us-east-2b',
    route_table       => 'nibiru_routetable_2',
    require           => Ec2_instance['nibiru_nat_instance']
  }

  ec2_vpc_internet_gateway { 'nibiru_igw':
    ensure => present,
    region => $region,
    vpc    => 'nibiru_vpc',
  }

  ec2_vpc_routetable { 'nibiru_routetable_1':
    ensure => present,
    vpc    => 'nibiru_vpc',
    region => $region,
    routes => [
      {
        destination_cidr_block => '10.0.0.0/16',
        gateway                => 'local'
      },{
        destination_cidr_block => '0.0.0.0/0',
        gateway                => 'nibiru_igw'
      },
    ],
  }

  ec2_vpc_routetable { 'nibiru_routetable_2':
    ensure  => present,
    vpc     => 'nibiru_vpc',
    region  => $region,
    routes  => [
      {
        destination_cidr_block => '10.0.0.0/16',
        gateway                => 'local'
      },{
        destination_cidr_block => '0.0.0.0/0',
        gateway                => 'nibiru_nat_instance'
      },
    ],
    require => Ec2_instance['nibiru_nat_instance']
  }

  ec2_securitygroup { 'nibiru_sec_group':
    ensure      => present,
    region      => $region,
    description => 'Nibiru V3 security group',
    ingress     => [{
      protocol => 'tcp',
      port     => '80',
      cidr     => '0.0.0.0/0'
    },{
      protocol => 'tcp',
      port     => '443',
      cidr     => '0.0.0.0/0'
    }]
  }

  ec2_instance { 'nibiru_nat_instance':
    ensure                      => present,
    instance_type               => 't2.micro',
    region                      => $region,
    subnet                      => 'nibiru_subnet_1',
    image_id                    => 'ami-36c29853',
    availability_zone           => 'us-east-2a',
    key_name                    => 'brain-surgery',
    security_groups             => ['nibiru_sec_group'],
    associate_public_ip_address => true,
  }
}
