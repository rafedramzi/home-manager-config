{ pkgs, pkgsUnstable, ... }:
[
  # GO;
  pkgsUnstable.golangci-lint # TODO: set your custom .golangci-lint rules file
  pkgsUnstable.golangci-lint-langserver
  # EDITOR
  #pkgs.neovide
  #pkgs.neovim-nightly
  #pkgs.neovim-qt
  #pkgs.neovim-remote
  # WASM
  pkgsUnstable.wabt
  # pkgsUnstable.usql
  pkgsUnstable.octosql
  pkgsUnstable.terragrunt
  ## pkgsUnstable.miler
  pkgsUnstable.ktlint
  pkgsUnstable.stern
  pkgsUnstable.tanka
  pkgsUnstable.gh
  pkgsUnstable.buf
  pkgsUnstable.opa
  pkgsUnstable.git-town
  pkgsUnstable.jwt-cli
  # data generator
  pkgsUnstable.dagger
  pkgsUnstable.synth
  # script runner
  #pkgsUnstable.mage # NOTE: I think magefile is bentter to be managed by go files, but we'll see if we can bundle all of our go dependency into a single nix packagea
  pkgsUnstable.dasht
  pkgsUnstable.pprof
  pkgsUnstable.grpcurl
  pkgsUnstable.temporal
  pkgsUnstable.nodePackages.typescript-language-server
  pkgsUnstable.sumneko-lua-language-server
  # protobuf
  pkgsUnstable.grpcui
  pkgsUnstable.protoc-gen-go
  pkgsUnstable.protoc-gen-twirp
  pkgsUnstable.protoc-gen-doc
  pkgsUnstable.protoc-gen-entgrpc
  pkgsUnstable.protoc-gen-validate
  pkgsUnstable.protoc-gen-connect-go
  pkgsUnstable.protoc-gen-twirp_swagger
] ++
[
  pkgsUnstable.gofumpt
]
++
[
  #pkgsUnstable.neovide
  #pkgsUnstable.neovim
] ++ [
  pkgsUnstable.buildpack
] ++ [
  pkgsUnstable.earthly
  pkgsUnstable.git-town
  pkgsUnstable.git-extras
  pkgsUnstable.git-secret
]
