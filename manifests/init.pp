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
#  class {'play':
#    version => "2.1.4",
#    user    => "appuser"
#  }
#  play::module {"mongodb module" :
#    module  => "mongo-1.3",
#    require => [Class["play"], Class["mongodb"]]
#  }
#
#  play::module { "less module" :
#    module  => "less-0.3",
#    require => Class["play"]
#  }
#
#  play::service { "bilderverwaltung" :
#    path    => "/home/clement/demo/bilderverwaltung",
#    require => [Jdk6["Java6SDK"], Play::Module["mongodb module"]]
#  }
#
class play (
  $version,
  $install_path = '/opt',
  $user= 'root'
) {

  include wget

  $play_path = "${install_path}/play-${version}"
  $download_url = "http://downloads.typesafe.com/play/${version}/play-${version}.zip"

  notice("Installing Play ${version}")
  wget::fetch {'download-play-framework':
    source      => $download_url,
    destination => "/tmp/play-${version}.zip",
    timeout     => 0,
  }

  exec { 'mkdir.play.install.path':
    command => "/bin/mkdir -p ${install_path}",
    unless  => "/bin/bash [ -d ${install_path} ]"
  }

  exec { 'unzip-play-framework':
    cwd     => $install_path,
    command => "/usr/bin/unzip /tmp/play-${version}.zip",
    unless  => "/usr/bin/test -d ${play_path}",
    require => [
      Package['unzip'],
      Wget::Fetch['download-play-framework'],
      Exec['mkdir.play.install.path']
    ],
  }

  exec { 'change ownership of play installation':
    cwd     => $install_path,
    command => "/bin/chown -R ${user}: play-${version}",
    require => Exec['unzip-play-framework']
  }

  file { "${play_path}/play":
    ensure  => file,
    owner   => $user,
    mode    => '0755',
    require => Exec['unzip-play-framework']
  }

  file {'/usr/bin/play':
    ensure  => 'link',
    target  => "${play_path}/play",
    require => File["${play_path}/play"],
  }

  # Add a unversioned symlink to the play installation.
  file { "${install_path}/play":
    ensure  => link,
    target  => $play_path,
    require => Exec['mkdir.play.install.path', 'unzip-play-framework']
  }

  if !defined(Package['unzip']) {
    package{ 'unzip': ensure => installed }
  }
}
