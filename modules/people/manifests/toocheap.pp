class people::toocheap (
    $apk = $people::toocheap::params::apk,
    $home = $people::toocheap::params::home,
    $dotfiles = $people::toocheap::params::dotfiles
) inherits people::toocheap::params {
  ## Declare all subclasses
  include people::toocheap::applications
  include people::toocheap::repos
  include people::toocheap::config
}
