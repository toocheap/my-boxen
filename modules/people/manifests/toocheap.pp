#
# vim: ft=puppet fenc=utf-8
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
            "gibo",
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
        # 'macvim-kaoriya-20131024':
        #    source => "https://code.google.com/p/macvim-kaoriya/downloads/detail?name=macvim-kaoriya-20131024.dmg",
        #    provider => compressed_app;
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
        require => File[$vim_vimproc],
    }
    $vim_proc_after = "make"
    exec { $vim_proc_after:
        cwd     => $vim_vimproc,
        require => Repository[$vim_vimproc],
    }

    # $vimPluginInstall = 'yes | vim -N -u NONE -i NONE -V1 -e -s --cmd "source ~/.vimrc" --cmd NeoBundleInstall! --cmd qall!'
    # exec { $vimPluginInstall:
    #     cwd     => $dust_vim,
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
    $RictyPowerline = "$fontpath/Ricty Regular for Powerline.ttf"
    $srcRictyPowerline = "https://www.dropbox.com/s/9kfxquv6m4nwd9e/Ricty%20Regular%20for%20Powerline.ttf"
    remote_file {"$RictyPowerline":
        remote_location => $srcRictyPowerline
    }
    exec { 'font-cache update':
        command => "fc-cache -vf $fontpath",
        timeout => 0,
        onlyif  => [
            "test ! -f $Inconsolata",
            "test ! -f $RictyRegular",
            "test ! -f $RictyBold",
            "test ! -f $RictyPowerline",
        ],
        require => [ Package['fontconfig'], File[$Inconsolata], File[$RictyRegular], File[$RictyBold], File[$RictyPowerline] ]
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

