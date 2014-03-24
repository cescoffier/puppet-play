# Resource: play::service
# Represents a Play application started as a service using an upstart script.
#
# Launches Play application using a system service.  This resource creates an
# upstart script, but does not declare a Puppet service.
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
# [*group*]
#  the group used to start the Play application (root by default)
#
# [*user*]
#  the user used to start the Play application (root by default)
#
# == Examples
#
#   play::service { "bilderverwaltung" :
#     path => "/home/clement/demo/bilderverwaltung",
#     group => "bilderverwaltung"
#     user => "bilderverwaltung"
#     require => [Play::Module["mongodb module"]]
#   }
#
define play::service(
  $path,
  $frameworkId = '',
  $javaOptions = '',
  $user = 'root',
  $group = 'root'
) {
  include play

  # Make play_home accessible from the template
  $play_home = $play::play_path

  file { "/etc/init/${title}.conf":
    content => template('play/play-upstart.erb'),
    mode    => '0755',
  }
}
