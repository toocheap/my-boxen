#
# vim: ft=puppet fenc=utf-8
#
class people::toocheap::config (
    $apk = $people::toocheap::params::apk,
    $home = $people::toocheap::params::home,
    $dotfiles = $people::toocheap::params::dotfiles
) {

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


    # Create Vim misc. directories
    $vim_home     = "${home}/.vim"
    file { $vim_home:
        ensure => directory
    }
    $vim_swap     = "${vim_home}/vim_swap"
    file { $vim_swap:
        ensure  => directory,
        require => File[$vim_home],
    }
    $vim_backup   = "${vim_home}/vim_backup"
    file { $vim_backup:
        ensure => directory,
        require => File[$vim_home],
    }
    $vim_undo   = "${vim_home}/vim_undo"
    file { $vim_undo:
        ensure => directory,
        require => File[$vim_home],
    }
    $vim_bundle  = "${vim_home}/bundle"
    file { $vim_bundle:
        ensure => directory,
        require => File[$vim_home],
    }
    $vim_neobundle = "$vim_bundle/neobundle.vim"
    file { $vim_neobundle:
        ensure => directory,
        require => File[$vim_bundle],
    }
    repository { $vim_neobundle:
        source  => "Shougo/neobundle.vim",
        require => File[$vim_neobundle]
    }
    $vim_vimproc = "$vim_bundle/vimproc.vim"
    file { $vim_vimproc:
        ensure => directory,
        require => File[$vim_bundle],
    }
    repository { $vim_vimproc:
        source  => "Shougo/vimproc.vim",
        require => File[$vim_vimproc],
    }
    $vim_proc_after = "make"
    exec { $vim_proc_after:
        cwd     => $vim_vimproc,
        require => Repository[$vim_vimproc],
    }
    repository { "$vim_bundle/vim-colors-solarized":
        source      => 'altercation/vim-colors-solarized.git',
        require => File["$vim_bundle"],
    }

    # $vimPluginInstall = 'yes | vim -N -u NONE -i NONE -V1 -e -s --cmd "source ~/.vimrc" --cmd NeoBundleInstall! --cmd qall!'
    # exec { $vimPluginInstall:
    #     cwd     => $vim,
    #     onlyif  => "test ! -d ~/.vim/bundle/unite.vim",
    #     require => [ Repository[$vim_neobundle], File["$home/.vimrc"] ]
    # }

    # Font Install
    define remote_file ($remote_location, $mode='0644') {
        exec{"retrieve_$title":
            command => "curl -s $remote_location -o $title",
            creates => "$title",
        }

        file{"$title":
            mode    => $mode,
            require => Exec["retrieve_$title"],
        }
    }

    $fontpath = "${home}/Library/Fonts"

    $Inconsolata = "$fontpath/Inconsolata.otf"
    $srcInconsolata  = "https://www.dropbox.com/s/epbo5t3opv54d7q/Inconsolata.otf"
    remote_file { "$Inconsolata":
        remote_location => $srcInconsolata
    }
    $RictyRegular = "$fontpath/Ricty-Regular.ttf"
    $srcRictyRegular = "https://www.dropbox.com/s/r94cpx3wtit2na1/Ricty-Regular.ttf"
    remote_file { "$RictyRegular":
        remote_location => $srcRictyRegular
    }
    $RictyBold = "$fontpath/Ricty-Bold.ttf"
    $srcRictyBold    = "https://www.dropbox.com/s/e8tsll05noadrcn/Ricty-Bold.ttf"
    remote_file { "$RictyBold":
        remote_location => $srcRictyBold
    }
    # $RictyPowerline = "$fontpath/Ricty Regular for Powerline.ttf"
    # $srcRictyPowerline = "https://www.dropbox.com/s/9kfxquv6m4nwd9e/Ricty%20Regular%20for%20Powerline.ttf"
    # remote_file {"$RictyPowerline":
    #     remote_location => $srcRictyPowerline
    # }
    exec { 'font-cache update':
        command => "fc-cache -vf $fontpath",
        timeout => 0,
        onlyif  => [
            "test ! -f $Inconsolata",
            "test ! -f $RictyRegular",
            "test ! -f $RictyBold",
#            "test ! -f $RictyPowerline",
        ],
        require => [
            Package['fontconfig'],
            File[$Inconsolata],
            File[$RictyRegular],
            File[$RictyBold],
#            File[$RictyPowerline],
        ]
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
        require => [ File[$apk], Package['Dropbox'] ]
    }
    file { "$home/.Rprofile":
        ensure  => link,
        mode    => '0644',
        target  => "$dotfiles/dot.Rprofile",
        require => Repository["$dotfiles"],
    }
    file { "$home/.bash_profile":
        ensure  => link,
        mode    => '0644',
        target  => "$dotfiles/dot.bash_profile",
        require => Repository["$dotfiles"],
    }
    file { "$home/.bashrc":
        ensure  => link,
        mode    => '0644',
        target  => "$dotfiles/dot.bashrc",
        require => Repository["$dotfiles"],
    }
    file { "$home/.gitconfig":
        ensure  => link,
        mode    => '0644',
        target  => "$dotfiles/dot.gitconfig",
        require => Repository["$dotfiles"],
    }
    file { "$home/.vimrc":
        ensure  => link,
        mode    => '0644',
        target  => "$dotfiles/dot.vimrc",
        require => Repository["$dotfiles"],
    }
    file { "$home/.gvimrc":
        ensure  => link,
        mode    => '0644',
        target  => "$dotfiles/dot.gvimrc",
        require => Repository["$dotfiles"],
    }
    file { "$home/.inputrc":
        ensure  => link,
        mode    => '0644',
        target  => "$dotfiles/dot.inputrc",
        require => Repository["$dotfiles"],
    }
    file { "$home/.mailcap":
        ensure  => link,
        mode    => '0644',
        target  => "$dotfiles/dot.mailcap",
        require => Repository["$dotfiles"],
    }
    file { "$home/.pystartup":
        ensure  => link,
        mode    => '0644',
        require => Repository["$dotfiles"],
    }
    file { "$home/.tmux.conf":
        ensure  => link,
        mode    => '0644',
        require => Repository["$dotfiles"],
    }
    file { "$home/.profile":
        ensure  => link,
        mode    => '0644',
        target  => "$dotfiles/dot.profile",
        require => Repository["$dotfiles"],
    }
    file { "$home/.gdbinit":
        ensure  => link,
        mode    => '0644',
        target  => "$dotfiles/dot.gdbinit",
        require => Repository["$dotfiles"],
    }
    file { "$home/.jshintrc":
        ensure  => link,
        mode    => '0644',
        target  => "$dotfiles/dot.jshintrc",
        require => Repository["$dotfiles"],
    }
    # Create global gitignore by gibo
    exec { "gibo C C++ CMake Django Erlang Go Haskell Java Objective-C Perl Python R Rails Ruby >> .gitignore":
        cwd     => "$home",
        creates => "$home/.gitignore",
        require => Package["gibo"]
    }
}

