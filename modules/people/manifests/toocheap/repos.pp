#
# vim: ft=puppet fenc=utf-8
#
class people::toocheap::repos (
    $apk = $people::toocheap::params::apk,
    $home = $people::toocheap::params::home,
    $dotfiles = $people::toocheap::params::dotfiles
){
    # Solarized
    $SolarizedRepo = "$apk/Solarized"
    file { $SolarizedRepo:
        ensure => directory,
    }
    repository { "$SolarizedRepo":
        source => 'altercation/solarized',
    }
}
