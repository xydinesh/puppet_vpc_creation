# Class: vpc_creation::destroy
# ============================
#
# Destroy vpc with all of it's resources
class vpc_creation::destroy (
  $region
){
  ec2_instance { 'nibiru_nat_instance':
    ensure => absent,
    region => $region,
  }~>
  ec2_securitygroup { 'nibiru_sec_group':
    ensure => absent,
    region => $region
  }~>

  ec2_vpc_internet_gateway { 'nibiru_igw':
    ensure => absent,
    region => $region,
  }~>

  ec2_vpc_subnet { 'nibiru_subnet_2':
    ensure => absent,
    region => $region,
  } ~>

  ec2_vpc_routetable { 'nibiru_routetable_2':
    ensure => absent,
    region => $region,
  } ~>

  ec2_vpc_subnet { 'nibiru_subnet_1':
    ensure => absent,
    region => $region,
  } ~>

  ec2_vpc_routetable { 'nibiru_routetable_1':
    ensure => absent,
    region => $region,
  } ~>

  ec2_vpc { 'nibiru_vpc':
    ensure => absent,
    region => $region,
  }
}
