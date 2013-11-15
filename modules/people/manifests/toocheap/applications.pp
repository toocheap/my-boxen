#
# vim: ft=puppet fenc=utf-8
#
class people::toocheap::applications (
    $apk = $people::toocheap::params::apk,
    $home = $people::toocheap::params::home,
    $dotfiles = $people::toocheap::params::dotfiles
){
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
    #    include hazel
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
            "tig",
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

    vagrant::plugin { 'vagrant-global-status': }

}

