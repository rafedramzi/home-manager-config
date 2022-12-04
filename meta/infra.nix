{ pkgs, pkgsUnstable, ... }:
[
    pkgsUnstable.boundary
    pkgsUnstable.waypoint
    pkgsUnstable.hey
    pkgsUnstable.google-cloud-sdk
]
++
[
  pkgsUnstable.coredns
]
++
# K8s
[
  pkgsUnstable.krew
  pkgsUnstable.stern
  pkgsUnstable.sonobuoy
  pkgsUnstable.fluxctl
  pkgsUnstable.kapp
  pkgsUnstable.kubernetes-helm
]
++
# wasm
[
    pkgsUnstable.wasmtime
]
