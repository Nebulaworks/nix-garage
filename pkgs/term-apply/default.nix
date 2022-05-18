{ lib, buildGoModule, fetchFromGitHub }:

let
  src = fetchFromGitHub {
    owner = "nebulaworks";
    rev = "b9d129b6b626dfd81c36e4c555822f86f5e95b76";
    repo = "orion";
    sha256 = "sha256:0483vyfrdc55cb1zda73za8ppjk5g7sljyjb0aj87f75qrgf4cv7";
  };

in
buildGoModule rec {
  inherit src;
  pname = "term-apply-unstable";
  version = "2022-05-17";

  sourceRoot = "${src.name}/apps/term-apply";

  vendorSha256 = "sha256-DA923aOtIvvzre6PFUwrnHwb0WMe67v3eqp0Ejm1ArI=";

  ldflags = [
    "-X github.com/nebulaworks/orion/apps/term-apply/pkg/version.Commit=${src.rev}"
    "-X github.com/nebulaworks/orion/apps/term-apply/pkg/version.BuildTime=01011970"
  ];

  meta = with lib; {
    description = "SSH Daemon for resume applicants to Nebulaworks";
    homepage = "https://github.com/orion";
    maintainers = [ "NWI" ];
    license = licenses.bsd3;
  };
}
