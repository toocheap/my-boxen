# This file manages Puppet module dependencies.
#
# It works a lot like Bundler. We provide some core modules by
# default. This ensures at least the ability to construct a basic
# environment.

def github(name, version, options = nil)
  options ||= {}
  options[:repo] ||= "boxen/puppet-#{name}"
  mod name, version, :github_tarball => options[:repo]
end

# Includes many of our custom types and providers, as well as global
# config. Required.

github "boxen",      "3.0.2"
github "sysctl",     "1.0.0"
github "property_list_key", "0.1.0", :repo => "glarizza/puppet-property_list_key"

# Core modules for a basic development environment. You can replace
# some/most of these if you want, but it's not recommended.

github "autoconf",   "1.0.0"
github "dnsmasq",    "1.0.0"
github "gcc",        "2.0.1"
github "git",        "1.2.5"
github "homebrew",   "1.4.1"
github "hub",        "1.0.3"
github "inifile",    "1.0.0", :repo => "puppetlabs/puppetlabs-inifile"
github "nginx",      "1.4.2"
github "nodejs",     "3.2.9"
github "openssl",    "1.0.0"
github "repository", "2.2.0"
github "ruby",       "6.3.4"
github "stdlib",     "4.1.0", :repo => "puppetlabs/puppetlabs-stdlib"
github "sudo",       "1.0.0"
github "xquartz",    "1.1.0"
github "postgresql",     "2.0.1" # via homebrew

# ---auto update---

# Optional/custom modules. There are tons available at
# https://github.com/boxen.
github "osx",            "2.0.0"
github "java",            "1.1.0"
github "libtool",        "1.0.0" # use for php
github "pkgconfig",      "1.0.0" # use for php
github "pcre",           "1.0.0" # use for php
github "libpng",         "1.0.0" # use for php
github "wget",           "1.0.0" # via homebrew
github "imagemagick",    "1.2.1" # via homebrew
github 'tmux',           "1.0.0" # via homebrew
github "heroku",         "2.0.0"
#github "php",            "1.1.0"
#github "mysql",          "1.1.0" # via homebrew
#github "phantomjs",      "2.0.2" # via homebrew
#github "omnigraffle",    "1.2.0"
#github "cyberduck",      "1.0.1"
#
# # local application for utility
github "droplr",         "1.0.1"
github "skydrive",       "1.0.1"
github "onepassword",    "1.0.2"
github "alfred",         "1.1.6"
github "dropbox",        "1.1.2"
github "vlc",            "1.0.5"
github "iterm2",         "1.0.3"
github "sublime_text_2", "1.1.2"
github "chrome",         "1.1.2"
github "firefox",        "1.1.4"
github "virtualbox",     "1.0.9"
github "vagrant",        "3.0.0"
github "googledrive",    "1.0.2"
#github "hazel",          "0.0.4", :repo => "toocheap/puppet-hazel"
github "skitch",         "1.0.2"
github "skype",          "1.0.6"
#github "hipchat",        "1.0.7"
#github "flux",           "1.0.0"
#github "packer",         "1.0.1"
github "textwrangler",   "1.0.2"
github "caffeine",       "1.0.0"
# ---/auto update---
