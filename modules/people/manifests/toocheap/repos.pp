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
    $iterm2_solarized = "$SolarizedRepo/iterm2-colors-solarized"
    file { $iterm2_solarized:
        ensure => directory,
    }
    $iterm2_solarized_dark = "$iterm2_solarized/Solarized Dark.itermcolors"
    file { "$iterm2_solarized_dark":
        ensure => present,
        source => $iterm2_solarized_dark,
    }
    $iterm2_solarized_light = "$iterm2_solarized/Solarized Light.itermcolors"
    file { "$iterm2_solarized_light":
        ensure => present,
        source => $iterm2_solarized_light,
    }
}
