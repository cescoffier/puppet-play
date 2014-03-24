name    'cescoffier-play'
version '0.0.2'
source 'akquinet'
author 'Clement Escoffier - akquinet tech@spree Gmbh'
license 'Apache Software License 2.0'
summary 'Puppet resources to provision Play! applications and modules'
description "Provision play framework and define play modules and applications as resources. It requires a proper Java installation including the JAVA_HOME variable.

	include play
	play::module {'mongodb module' :
	 	module => 'mongo-1.3', 
		require => [Class['play'], Class['mongodb']]
	}

	play::module { 'less module' :
	 	module => 'less-0.3',
		require => Class['play']
	}

	play::service { 'bilderverwaltung' :
		path => '/home/clement/demo/bilderverwaltung',
		require => [Jdk6['Java6SDK'], Play::Module['mongodb module']]
	}
"

## Add dependencies, if any:
dependency 'maestrodev/wget', '>= 1.0.0'
