play::module
============

Resource representing a Play Module.

Actions
-------
Simply checks the availability of the module and installs it if needed.

Parameters
----------

* *module* : mandatory, the module name such as "less-0.3"

Examples
--------

	  play::module {"mongodb module" :
	 	module  => "mongo-1.3", 
		require => [Class["play"], Class["mongodb"]]
	  }
	  play::module { "less module" :
	 	module  => "less-0.3",
		require => Class["play"]
	  }
