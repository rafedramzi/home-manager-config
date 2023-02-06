{ config, lib, pkgs, ... }:

with builtins;
let
  pkgsUnstable = (import <nixpkgs-unstable> { });

  importDeps = { pkgs = pkgs; pkgsUnstable = pkgs; };
in
{
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "vscode"
    "postman"
  ];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "pwyll";
  home.homeDirectory = "/home/pwyll";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  programs.bat.enable = true;
  xresources = {
    extraConfig = readFile ./includes/xresources/xresources.conf;
  };

  programs.git = {
    enable = false; # TODO: Make sure you move all your home .gitconfig first
    userEmail = "rafedramzi@gmail.com";
    userName = "Rafed Ramzi";
    signing = {
      signByDefault = true;
      key = "rafedramzi@gmail.com";
    };
    includes = [
      {
        path = "~/Projects/rafedramzi/.gitconfig";
        condition = "~/Projects/rafedramzi/";
      }
      {
        path = "~/Work/freelance/.gitconfig";
        condition = "gitdir:~/Work/freelance/";
      }
    ];

    delta = {
      enable = false;
    };
    extraConfig = {
      commit = { gpgSign = true; };
      merge = { conflictStyle = "diff3"; };
      color = { ui = "true"; };
      init = { defaultBranch = "main"; };
      format = { signoff = "true"; };
    };

    diff-so-fancy = {
      enable = false;
    };
  };

  programs.zsh = {
    enable = true;
    history = {
      share = true;
      ignoreSpace = true;
    };
    oh-my-zsh = {
      # NOTE the part that we're intersted in is only
      # https://github.com/ohmyzsh/ohmyzsh/blob/master/lib/key-bindings.zsh
      # why enable full zsh then? laziness :D
      enable = true;
      #plugins = [ "key-bindings" ];
    };
    # zshrc
    initExtra = "alias ls=exa";
    #defaultKeymap = "emacs";
    # .zsh_env
    envExtra = "" +
      readFile ./includes/zsh/envs/terminalrc +
      readFile ./includes/zsh/envs/developmentrc +
      readFile ./includes/zsh/zsh_env;
    profileExtra =
      readFile ./includes/zsh/envs/terminalrc.zsh +
      readFile ./includes/zsh/zprofile +
      readFile ./includes/zsh/aliases/kubectl_aliases +
      readFile ./includes/zsh/aliases/terminal +
      readFile ./includes/zsh/aliases/utils;
  };

  services.polybar = {
    enable = true;
    package = (pkgs.callPackage pkgs.polybar.override ({
      nlSupport = true;
      mpdSupport = true;
      i3Support = true;
      alsaSupport = true;
      iwSupport = true;
      pulseSupport = true;
      githubSupport = true;

      # TODO: switch to uutils-coreutils :)
      # TODO: find other way to put the coreutils as the depdnency
    })).overrideAttrs (final: prev: {
      buildInputs = prev.buildInputs ++ [ pkgsUnstable.coreutils ];
    });
    # TODO: fix this mess
    extraConfig =
      readFile ./includes/polybar/config +
      readFile ./includes/polybar/global.conf +
      readFile ./includes/polybar/bars/top.conf;
    # handled by i3?
    script = ''
      MONITOR=eDP polybar -c ~/.config/polybar/config.ini top &
      MONITOR=eDP-1-0 polybar -c ~/.config/polybar/config.ini top &
      MONITOR=HDMI-0 polybar -c ~/.config/polybar/config.ini top &
    '';
  };

  programs.tmux = {
    enable = true;
    extraConfig = readFile ./includes/tmux/tmux.conf;
    plugins = with pkgs; [
      {
        plugin = tmuxPlugins.resurrect;
      }
    ];
    keyMode = "vi";
  };


  programs.vscode = {
    enable = true;
  };

  # NOTE: MANAGED MANUALLY, I DON'T LIKE THE WAY HOME-AMANGER MANAGING MY VIM CONFI
  programs.neovim = {
    enable = false;
  };

  programs.zellij = {
    enable = true;
  };

  programs.zoxide = {
    enable = true;
  };

  qt = {
    enable = true;
  };

  systemd.user.startServices = pkgs.stdenv.isLinux;

  home.file = {
    ".config/kitty/" = {
      source = ./includes/kitty;
    };
    ".config/containers/" = {
      source = ./includes/containers;
    };
    ".config/i3/" = {
      source = ./includes/i3;
    };
    ".gdbinit" = {
      source = ./includes/gdb/.gdbinit;
    };
    ".cargo/config" = {
      source = ./includes/cargo/config;
    };
    #};
    ".config/nvim/" = {
      source = ./includes/nvim;
    };
    ".config/picom/" = {
      source = ./includes/picom;
    };
    ".config/rofi/" = {
      source = ./includes/rofi;
    };
    "scripts/" = {
      source = ./includes/scripts;
    };
    ".config/starship.toml" = {
      source = ./includes/starship/starship.toml;
    };
    ".config/sway/" = {
      source = ./includes/sway;
    };
    ".config/zathura/" = {
      source = ./includes/zathura;
    };
    ".config/polybar/quote.sh" = {
      source = ./includes/polybar/quote.sh;
    };
    ".config/polybar/quotes.txt" = {
      source = ./includes/polybar/quotes.txt;
    };
  };

  home.packages = [ ]
    ++ import ./meta/container_tools.nix importDeps
    ++ import ./meta/cli_tools.nix importDeps
    ++ import ./meta/desktop.nix importDeps
    ++ import ./meta/dev_tools.nix importDeps
    ++ import ./meta/fun_tools.nix importDeps
    ++ import ./meta/infra.nix importDeps
    ++ import ./meta/nix_tools.nix importDeps
    ++ import ./meta/pl.nix importDeps
    ++ import ./meta/terminal.nix importDeps;
  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };
  programs.keychain = {
    enable = true;
    enableXsessionIntegration = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    keys = [ "id_rsa" "id_ed25519" ];
  };
  xsession = {
    enable = true;
    # initExtra = readFile ./includes/xsession/xsession;
    numlock.enable = true;
    windowManager.i3 = {
      package = pkgs.i3;
      enable = true;
      extraConfig = readFile ./includes/i3/config;
    };
  };
}
