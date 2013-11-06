#
# vim: ft=ruby fenc=utf-8
#
class people::toocheap {

  include osx::finder::unhide_library
  class osx::finder::show_all_files {
    include osx::finder
    boxen::osx_defaults { 'Show all files':
      user   => $::boxen_user,
      domain => 'com.apple.finder',
      key    => 'AppleShowAllFiles',
      value  => false,
      notify => Exec['killall Finder'];
    }
  }
  include osx::finder::show_all_files

#  Dock
  include osx::dock::autohide

  class osx::dock::kill_dashbord{
    include osx::dock
    boxen::osx_defaults { 'kill dashbord':
      user   => $::boxen_user,
      domain => 'com.apple.dashboard',
      key    => 'mcx-disabled',
      value  => YES,
      notify => Exec['killall Dock'];
    }
  }
  include osx::dock::kill_dashbord

#  Universal Access
  include osx::universal_access::ctrl_mod_zoom
  include osx::universal_access::enable_scrollwheel_zoom

#  Miscellaneous
  include osx::no_network_dsstores # disable creation of .DS_Store files on network shares
  include osx::software_update # download and install software updates

#  include turn-off-dashboard

  include java
  include homebrew
  include libtool
  include pkgconfig
  include pcre
  include libpng
  include imagemagick
  include dropbox
  include iterm2::stable
  include chrome
  include firefox
  include sublime_text_2
  include virtualbox
  include alfred
  include vlc
  include onepassword
  include vagrant
  include hazel
#  include packer
  include textwrangler
  include caffeine
  include droplr
  include skydrive
  include googledrive
  include postgresql
  include heroku
  include skype

  # Install via homebrew
  package {
    [
      "autoconf",
      "autojump",
      "automake",
      "bash-completion",
      "binutils",
      "bison",
      "cmake",
      "cmigemo",
      "ctags",
      "fontconfig",
      "fontforge",
      "freetype",
      "gdbm",
      "jenkins",
      "jpeg",
      "jq",
      "libassuan",
      "libevent",
      "libffi",
      "libgcrypt",
      "libnet",
      "libtiff",
      "libxml2",
      "libyaml",
      "lv",
      "lynx",
      "markdown",
      "neon",
      "nkf",
      "nmap",
      "parallel",
      "readline",
      "rbenv-gemset",
      "sqlite",
      "tree",
      "w3m",
      'coreutils',        # for dircolors
      'reattach-to-user-namespace',
      'tmux',
      'wget',
  ]:
  }

  package {
    'GoogleJapaneseInput':
    source => "http://dl.google.com/japanese-ime/latest/GoogleJapaneseInput.dmg",
    provider => pkgdmg;
#    'macvim-kaoriya-20131024':
#    source => "https://code.google.com/p/macvim-kaoriya/downloads/detail?name=macvim-kaoriya-20131024.dmg",
#    provider => pkgdmg;
  }

  $home = "/Users/${::luser}"
  $apk  = "${home}/Dropbox/apk"
  $dotfiles = "${apk}/dotfiles"

  # Create Vim misc. directories
  $dust_vim     = "${dust}/.vim"
  file { $dust_vim:
    ensure => directory
  }
  $dust_vim_swap     = "${dust_vim}/vim_swap"
  file { $dust_vim_swap:
    ensure => directory
  }

  $dust_vim_backup   = "${dust_vim}/vim_backup"
  file { $dust_vim_backup:
    ensure => directory
  }

  $dust_vim_undo   = "${dust_vim}/vim_undo"
  file { $dust_vim_undo:
    ensure => directory
  }

  $dust_vim_bundle  = "${dust_vim}/vim_bundle"
  file { $dust_vim_bundle:
    ensure => directory
  }

  $vim_neobundle = "$dust_vim_bundle/neobundle.vim"
  file { $vim_neobundle:
    ensure => directory
  }

  repository { $vim_neobundle:
    source  => "Shougo/neobundle.vim",
    require => File[$vim_neobundle]
  }

  $vim_vimproc = "$dust_vim_bundle/vimproc.vim"
  file { $vim_vimproc:
    ensure => directory
  }
  repository { $vim_vimproc:
    source  => "Shougo/vimproc.vim",
    require => File[$vim_vimproc]
  }

  # dotfiles
  file { $dotfiles:
    ensure => directory
  }
  file { $apk:
    ensure => directory
  }
  repository { $dotfiles:
    source  => "toocheap/dotfiles",
    require => File[$apk]
  }

}
