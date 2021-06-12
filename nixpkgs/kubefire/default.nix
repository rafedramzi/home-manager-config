{lib, fetchFromGithub, buildGoModule}:

buildGoModule rec {
  pname = "kubefire";
  version = "v0.3.6";

  src = fetchFromGithub {
    owner = "innobead";
    repo = pname;
    rev = version;
    sha256 = "sha256-9413383b5a90160cbb115c593167b06658fd832f";
  };

  goPackagePath = "github.com/innobead/kubefire/cmd/kubefire";

  meta = with lib; {
    description = "KubeFire 🔥, creates and manages Kubernetes Clusters using Firecracker microVMs";
    longDescription = ''
      KubeFire is to create and manage Kubernetes clusters running on FireCracker microVMs via weaveworks/ignite.

      - Uses independent rootfs and kernel from OCI images instead of traditional VM images like qcow2, vhd, etc
      - Uses containerd to manage Firecracker processes
      - Have different cluster bootstappers to provision Kubernetes clusters like Kubeadm, K3s, Rancher RKE, RKE2, RancherD, and K0s
      - Supports deploying clusters on different architectures like x86_64/AMD64 and ARM64/AARCH64 (ex: K3s, RKE2, K0s)
    '';

    license = licenses.apache2;
    homepage = "https://github.com/innobead/kubefire";
    maintainers = with maintainers; [ rafedramzi ];
    platforms = with platforms; unix;
  };

}
