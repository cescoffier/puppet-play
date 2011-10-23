Play Class
==========

Actions:
--------
If not already installed, play 1.2.3 is downloaded and installed into _/opt/play-1.2.3_. 

 Requires:
-----------

* A proper java installation and JAVA_HOME set

Sample Usage:
-------------

	  include play
	  play::module {"mongodb module" :
	 	module  => "mongo-1.3", 
		require => [Class["play"], Class["mongodb"]]
	  }
	  play::module { "less module" :
	 	module  => "less-0.3",
		require => Class["play"]
	  }
	  play::service { "bilderverwaltung" :
		path    => "/home/clement/demo/bilderverwaltung",
		require => [Jdk6["Java6SDK"], Play::Module["mongodb module"]]
	  }
