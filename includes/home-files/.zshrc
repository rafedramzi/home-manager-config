##!/bin/zsh
# To profile
#zmodload zsh/zprof

export PATH="$HOME/bin:$PATH"
export NIX_PATH=$HOME/.nix-defexpr/channels${NIX_PATH:+:}$NIX_PATH
export NIX_PATH=$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels${NIX_PATH:+:$NIX_PATH}
source $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh
export PATH="${PATH}:${HOME}/.krew/bin"
if [ -e /home/pwyll/.nix-profile/etc/profile.d/nix.sh ]; then . /home/pwyll/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

source ~/.dotfiles/launch_zsh.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export GPG_TTY=$(tty)
setopt SHARE_HISTORY


## Sway : source https://github.com/swaywm/sway/issues/5008
## this may fix external monitor problem
#WLR_DRM_NO_MODIFIERS=1
#
## make Firefox use native Wayland backend
#MOZ_ENABLE_WAYLAND=1
## force wayland backend for bemenu
#BEMENU_BACKEND=wayland
#
## Force Wayland backend for qt5 apps
#QT_QPA_PLATFORM=wayland
#QT_WAYLAND_DISABLE_WINDOWDECORATION=1
#
## for Java some apps
# _JAVA_AWT_WM_NONREPARENTING=1
#
## general
#XDG_SESSION_TYPE=wayland
## End of sway

# pnpm
export PNPM_HOME="/home/pwyll/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end
