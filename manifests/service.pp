# Resource: play::service
# Represents a Play application started as a service.
#
# Launches Play application using a system service.
# This resource handles a service script in /etc/init.d/title
#
# == Parameters
#
# [*path*] 
#  mandatory, absolute path of the application.
#
# [*frameworkId*]
#  the framework id to start the application (no framework id by default)
#
# [*javaOptions*]
#  the java options to configure the JVM on which the application will run
#
# == Examples
#
#   play::service { "bilderverwaltung" :
#	  path => "/home/clement/demo/bilderverwaltung",
#	  require => [Jdk6["Java6SDK"], Play::Module["mongodb module"]]
#   }
#
define play::service($path, $frameworkId = "", $javaOptions = "", $user = "root", $group = "root") {
	include play
	
	# Make play_home accessible from the template
	$play_home = $play::play_path
	
	file { "/etc/init/$title.conf":
		content => template("play/play-upstart.erb"),
		mode    => "0755",
		notify  => Service["play-$title"],
	}
	
	#service { "play-$title":
	#	 ensure  => true,
	#     enable  => true,
	#	 name    => $title,
	#	 require => File["/etc/init.d/${title}"]
	#}
	
}