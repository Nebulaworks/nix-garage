{ lib, buildGoModule, fetchFromGitHub }:

let
  src = fetchFromGitHub {
    owner = "nebulaworks";
    rev = "3a1aca5aa9a31815d915c145010a7432f41c10aa";
    repo = "orion";
    sha256 = "sha256:1a1ympq4654rx46s45pwn0dxdn6mbj1nqv1f7n6h72jszi09y34g";
  };

in
buildGoModule rec {
  inherit src;
  pname = "term-apply-unstable";
  version = "2022-03-29";

  sourceRoot = "${src.name}/apps/term-apply";

  vendorSha256 = "sha256-DA923aOtIvvzre6PFUwrnHwb0WMe67v3eqp0Ejm1ArI=";

  ldflags = [
    "-X github.com/nebulaworks/orion/apps/term-apply/pkg/version.Commit=${src.rev}"
    "-X github.com/nebulaworks/orion/apps/term-apply/pkg/version.BuildTime=01011970"
  ];

  meta = with lib; {
    description = "SSH Daemon for resume applicants to nebulaworks";
    homepage = "https://github.com/orion";
    maintainers = "NWI";
    license = licenses.bsd3;
  };
}
