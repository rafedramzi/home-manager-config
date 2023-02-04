{ pkgs, pkgsUnstable, ... }:
[
  pkgsUnstable.antibody
  pkgsUnstable.bat
  pkgsUnstable.spaceship-prompt
  pkgsUnstable.zsh # TODO: Set default set for user
  pkgsUnstable.starship
  pkgsUnstable.exa
  pkgsUnstable.fd
  pkgsUnstable.ripgrep
  pkgsUnstable.direnv
  # file browsers
  pkgsUnstable.lf
  pkgsUnstable.nnn
]
++ [
  pkgsUnstable.tree
  pkgsUnstable.jq
  pkgsUnstable.yq-go
  pkgsUnstable.parallel
]

