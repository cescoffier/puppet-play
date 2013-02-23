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
# Parameters:
# *version* : the Play version to install
#
# Requires:
# wget puppet module https://github.com/EslamElHusseiny/puppet-wget
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
class play ($version = "1.2.3") {

	include wget

	$play_version = $version
	$play_path = "/opt/play-${play_version}"
	$download_url = $play_version ? {
	  '2.1.0' => "http://downloads.typesafe.com/play/${play_version}/play-${play_version}.zip",
	  default => "http://downloads.typesafe.com/releases/play-${play_version}.zip",
	}
	
	notice("Installing Play ${play_version}")
        wget::fetch {'download-play-framework':
          source      => "$download_url",
          destination => "/tmp/play-${play_version}.zip",
          timeout     => 0,
        }

	exec {"unzip-play-framework":
	cwd     => "/opt",
        command => "/usr/bin/unzip /tmp/play-${play_version}.zip",
        unless  => "test -d $play_path",
        require => [ Package["unzip"], Wget::Fetch["download-play-framework"] ],
	}
	
	file { "$play_path/play":
	    ensure  => file,
	    owner   => "root",
	    mode    => "0755",
	    require => [Exec["unzip-play-framework"]]
	}

	file {'/usr/bin/play':
	    ensure  => 'link',
	    target  => "$play_path/play",
	    require => File["$play_path/play"],
	}
	
	if !defined(Package['unzip']){ package{"unzip": ensure => installed} }	
}
