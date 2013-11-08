class people::toocheap::params {
  # $::luser and $::boxen_srcdir come from Boxen's custom facts
  $home = "/Users/${::luser}"
  $apk  = "${home}/Dropbox/apk"
  $dotfiles = "${apk}/dotfiles"
}
