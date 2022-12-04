{ pkgs, pkgsUnstable, ... }:
[
  pkgsUnstable.buildah
  pkgsUnstable.podman
  pkgsUnstable.slirp4netns
  pkgsUnstable.dive
  pkgsUnstable.octant
  pkgsUnstable.skopeo
  pkgsUnstable.trivy
  pkgsUnstable.k3s
  pkgsUnstable.kube3d
  pkgsUnstable.kind
  pkgsUnstable.nerdctl
  pkgsUnstable.kube-linter
]

