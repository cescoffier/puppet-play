play::application
==================

Resource representing a Play application.

Actions
-------
If the application needs to be launched, the dependencies are resolved first.
The application is launched only if the _service.pid_ file does not exist.

The application is launched by executing _play dependencies_ followed by _play start_.
The application is stopped using _play stop_.

Parameters
----------

* *path* : mandatory, absolute path of the application.
* *sync* : enables dependency sync before starting the application. Accepted values are _{true, false}_ (_false_ by default).
* *ensure* : checks that the application is running/stopped, starts/stops it if needed. Accepted value are _{running, stopped}_. (_running_ by default)
* *frameworkId* : the framework id to start the application (no framework id by default)
* *javaOptions* : the java options to configure the JVM on which the application will run

Examples
--------

	   play::application { "bilderverwaltung" :
		  path    => "/home/clement/demo/bilderverwaltung",
	     require => [Jdk6["Java6SDK"], Play::Module["mongodb module"]]
	   }

	   play::application { "bilderverwaltung" :
	     ensure  => running,
		  path    => "/home/clement/demo/bilderverwaltung",
	   }

	   play::application { "bilderverwaltung" :
	     ensure  => stopped,
		  path    => "/home/clement/demo/bilderverwaltung",
	   }

	   play::application { "bilderverwaltung" :
	     ensure  => running,
	     sync    => true,
		  path    => "/home/clement/demo/bilderverwaltung",
	   }

	   play::application { "bilderverwaltung" :
	     ensure  => running,
		  path    => "/home/clement/demo/bilderverwaltung",
	     frameworkId => "prod",
	     javaOptions => -Xx1024m
	   }
