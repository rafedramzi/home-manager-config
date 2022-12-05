{ config, pkgs, ... }:
with builtins;
let
  pkgsUnstable = import <nixpkgs-unstable>;
  importDeps = { pkgs = pkgs; pkgsUnstable = pkgs; };
in
{
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
      # plugins = [ "key-bindings" ];
    };
    # zshrc
    initExtra = "";
    defaultKeymap = "emacs";
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

  programs.tmux = {
    enable = true;
    extraConfig = readFile ./includes/tmux/tmux.conf;
  };


  programs.vscode = {
    enable = false;
    extensions = with pkgsUnstable; [
      aaron-bond.better-comments
      ahmadawais.shades-of-purple
      alefragnani.Bookmarks
      alefragnani.project-manager
      attilabuti.vscode-mjml
      BazelBuild.vscode-bazel
      bufbuild.vscode-buf
      christian-kohler.path-intellisense
      crystal-lang-tools.crystal-lang
      Dart-Code.dart-code
      Dart-Code.flutter
      DavidAnson.vscode-markdownlint
      dbaeumer.vscode-eslint
      dhedgecock.radical-vscode
      dracula-theme.theme-dracula
      dzannotti.vscode-babel-coloring
      eamodio.gitlens
      EditorConfig.EditorConfig
      esbenp.prettier-vscode
      ExodiusStudios.comment-anchors
      fabiospampinato.vscode-todo-plus
      firefox-devtools.vscode-firefox-debug
      formulahendry.code-runner
      foxundermoon.shell-format
      fwcd.kotlin
      golang.go
      GraphQL.vscode-graphql
      GraphQL.vscode-graphql-syntax
      GulajavaMinistudio.mayukaithemevsc
      hashicorp.hcl
      hashicorp.terraform
      hediet.debug-visualizer
      JakeBecker.elixir-ls
      jolaleye.horizon-theme-vscode
      julialang.language-julia
      kevinkyang.auto-comment-blocks
      mateocerquetella.xcode-12-theme
      mathiasfrohlich.Kotlin
      minhthai.vscode-todo-parser
      mjmcloug.vscode-elixir
      ms-python.python
      ms-python.vscode-pylance
      ms-toolsai.jupyter
      ms-toolsai.jupyter-keymap
      ms-toolsai.jupyter-renderers
      ms-toolsai.vscode-jupyter-cell-tags
      ms-toolsai.vscode-jupyter-slideshow
      ms-vscode.makefile-tools
      ms-vscode.vscode-typescript-next
      necinc.elmmet
      octref.vetur
      peterj.proto
      PKief.material-icon-theme
      plibither8.remove-comments
      quicktype.quicktype
      rebornix.ruby
      redhat.vscode-commons
      redhat.vscode-xml
      rocketseat.theme-omni
      rust-lang.rust
      rust-lang.rust-analyzer
      sbrink.elm
      Shan.code-settings-sync
      sleistner.vscode-fileutils
      smockle.xcode-default-theme
      streetsidesoftware.code-spell-checker
      svelte.svelte-vscode
      tamasfe.even-better-toml
      tinkertrain.theme-panda
      tsandall.opa
      vadimcn.vscode-lldb
      vscodevim.vim
      wesbos.theme-cobalt2
      wingrunr21.vscode-ruby
      wmaurer.change-case
      xaver.clang-format
      yzhang.markdown-all-in-one
      ZainChen.json
      zxh404.vscode-proto3
    ];
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
  };

  home.packages = [ ]
    ++ import ./meta/container_tools.nix importDeps
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
