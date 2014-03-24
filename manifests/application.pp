# Resource: play::application
# Represents a Play application.
#
# If the application needs to be launched, the dependencies are resolved first.
# The application is launched only if the service.pid file does not exist
#
# == Parameters
#
# [*path*]
#  mandatory, absolute path of the application.
#
# [*sync*]
#  enable dependency sync before starting the application.
#  Accepted values are true|false (false by default).
#
# [*ensure*]
#  checks that the application is running (stopped),
#  starts (stopped) it if needed. Accepted value are
#  running|stopped. (running by default)
#
# [*frameworkId*]
#  the framework id to start the application (no framework id by default)
#
# [*javaOptions*]
#  the java options to configure the JVM on which the application will run
#
# == Examples
#
#   play::application { "bilderverwaltung" :
#     path    => "/home/clement/demo/bilderverwaltung",
#     require => [Jdk6["Java6SDK"], Play::Module["mongodb module"]]
#   }
#
#   play::application { "bilderverwaltung" :
#     ensure  => running,
#     path    => "/home/clement/demo/bilderverwaltung",
#   }
#
#   play::application { "bilderverwaltung" :
#     ensure  => stopped,
#     path    => "/home/clement/demo/bilderverwaltung",
#   }
#
#   play::application { "bilderverwaltung" :
#     ensure  => running,
#     sync    => true,
#     path    => "/home/clement/demo/bilderverwaltung",
#   }
#
#   play::application { "bilderverwaltung" :
#     ensure      => running,
#     path        => "/home/clement/demo/bilderverwaltung",
#     frameworkId => "prod",
#     javaOptions => -Xx1024m
#   }
#
define play::application(
  $path,
  $sync        = false,
  $ensure      = running,
  $frameworkId = '',
  $javaOptions = ''
) {
  include play

  $syncArgument = ''
  if $sync {
    $syncArgument = '--sync'
  }

  $frameworkArgument = ''
  if $frameworkId != '' {
    $frameworkArgument = "--%${frameworkId}"
  }

  if $ensure == running {
    notice("Running play application from ${path}")
    exec { "play-resolve-dependencies-${path}":
      command => "${play::play_path}/play dependencies ${syncArgument} ${path}",
      cwd     => $path,
      unless  => "test -f ${path}/server.pid",
    }

    exec { "start-play-application-${path}":
      command => "${play::play_path}/play start ${path} ${frameworkArgument} ${javaOptions}",
      cwd     => $path,
      unless  => "test -f ${path}/server.pid",
    }
  } else {
    notice("Stopping play application from ${path}")
    exec { "stop-play-application-${path}":
      command => "${play::play_path}/play stop ${path}",
      cwd     => $path,
      onlyif  => "test -f ${path}/server.pid",
    }
  }
}
