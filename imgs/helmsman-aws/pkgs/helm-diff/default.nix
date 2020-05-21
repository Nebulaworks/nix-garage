{ lib, buildGoPackage, fetchFromGitHub, ... }:

buildGoPackage rec {
  pname = "helm-diff";
  version = "3.1.1";

  src = fetchFromGitHub {
    owner = "databus23";
    repo = "helm-diff";
    rev = "v${version}";
    sha256 = "0dyzm06k3g04c7p08ld47x89fglkm6g83r1vw95vp4m7illzc07y";
  };

  goPackagePath = "github.com/databus23/helm-diff";
  goDeps = ./deps.nix;

  postInstall = ''
    mkdir -p $out/share/helm/plugins/helm-diff/bin/
    cp $src/plugin.yaml $out/share/helm/plugins/helm-diff/
    ln -s $out/bin/helm-diff $out/share/helm/plugins/helm-diff/bin/diff
  '';

  meta = with lib; {
    description = "Helm plugin that generates a diff and previews what a helm upgrade would change";
    homepage = "https://github.com/databus23/helm-diff";
    license = licenses.asl20;
    maintainers = with maintainers; [ lynty ];
    platforms = platforms.unix;
  };
}
