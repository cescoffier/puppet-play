# Resource: play::module
# Represents a Play Module.
#
# Simply checks the availability of the module and installs it if needed.
#
# == Parameters
#
# [*module*]
#  mandatory, the module name such as "less-0.3"
#
# == Examples
#
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
define play::module($module) {
  include play
  notice("Installing module ${module}")
  exec { "install-play-module-${module}":
    command => "yes | ${play::play_path}/play install ${module}",
    unless  => "test -d ${play::play_path}/play/${module}"
  }
}
