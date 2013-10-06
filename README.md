Puppet Module For Play
======================

This module provisions the Play Framework, manages Play modules and Play applications. It supports:

* The provisioning of Play Framework in _/opt/play-version_
* The installation of modules
* The management of Play applications
* The configuration of system services to run play applications

Using the module
----------------
To use the module, either

* Clone this repository to _/etc/puppet/modules_ (or configure your _modulepath_)
* Download a pre-packaged version (from the download section)

The module requires a proper Java installation including a valid __JAVA_HOME_ environment variable.

Example
-------

	class {'play': 
	   version => "2.1.4",
	   user    => "appuser"
    }
	
	play::module {"mongodb module" :
	 	module => "mongo-1.3", 
		require => [Class["play"], Class["mongodb"]]
	}
	
	play::module { "less module" :
	 	module => "less-0.3",
		require => Class["play"]
	}
	
	play::application { "bilderverwaltung" :
		ensure => running,
		path => "/home/clement/demo/bilderverwaltung",
		require => [Jdk6["Java6SDK"], Play::Module["mongodb module"]]
	}
	
	#Just create the upstart script, so the service is required
	play::service { "bilderverwaltung" :
		path => "/home/clement/demo/bilderverwaltung",
		require => [Play::Module["mongodb module"]]
	}
	
	


License
-------

This module is licensed under the Apache Software License 2.0.