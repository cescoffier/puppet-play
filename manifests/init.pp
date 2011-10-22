# Class: play
#
# This module manages play framework applications and modules.
# The class itself installs Play 1.2.3 in /opt/play-1.2.3
#
# Actions:
#  play::module checks the availability of a Play module. It installs
#  it if not found
#  play::application starts a play application
#  play::service starts a play application as a system service
#
# Requires:
# A proper java installation and JAVA_HOME set
# Sample Usage:
#  include play
#  play::module {"mongodb module" :
# 	module  => "mongo-1.3", 
#	require => [Class["play"], Class["mongodb"]]
#  }
#
#  play::module { "less module" :
# 	module  => "less-0.3",
#	require => Class["play"]
#  }
#
#  play::service { "bilderverwaltung" :
#	path    => "/home/clement/demo/bilderverwaltung",
#	require => [Jdk6["Java6SDK"], Play::Module["mongodb module"]]
#  }
#
class play {
	
	$play_version = "1.2.3"
	$play_path = "/opt/play-${play_version}"
	
	notice("Installing Play ${play_version}")
	exec { "download-play-framework":                                                                                                                     
        command => "wget http://download.playframework.org/releases/play-${play_version}.zip",                                                         
        cwd     => "/tmp",
        creates => "/tmp/play-${play_version}.zip",                                                              
		unless  => "test -d $play_path",
		require => [Package["wget"]]
    }

	exec {"unzip-play-framework":
	    cwd     => "/opt",
        command => "/usr/bin/unzip /tmp/play-${play_version}.zip",
        unless  => "test -d $play_path",
        require => [ Package["unzip"], Exec["download-play-framework"] ],
	}
	
	file { "$play_path/play":
		ensure  => file,
	    owner   => "root",
	    mode    => "0755",
		require => [Exec["unzip-play-framework"]]
	}
	
	package {
	    "unzip":
	        ensure => installed
	}
	
	package {
	    "wget":
	        ensure => installed
	}	
}
