play::service
==============

Resource representing a Play application started as a service.

Actions
-------
Launches Play application using a system service. 
This resource handles a service script in _/etc/init.d/app_.

The resource simply generates the scripts and add it as a Puppet Service.

Parameters
----------

* *path* :  mandatory, absolute path of the application.
* *frameworkId* : the framework id to start the application (no framework id by default)
* *javaOptions* : the java options to configure the JVM on which the application will run

Examples
--------

	   play::service { "bilderverwaltung" :
		  path => "/home/clement/demo/bilderverwaltung",
		  require => [Jdk6["Java6SDK"], Play::Module["mongodb module"]]
	   }

TODO
----

* Support _enabled_ parameter (to stop the service).