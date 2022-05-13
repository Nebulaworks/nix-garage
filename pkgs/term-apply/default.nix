{ lib, buildGoModule, fetchFromGitHub }:

let
  src = fetchFromGitHub {
    owner = "nebulaworks";
    rev = "fb0b1491c68afca0e06703835f984b371e0571e6";
    repo = "orion";
    sha256 = "sha256:12fv5ck0zv21f2q6qqlag1hdwr2dqblj9c02mnvwxscqrya907nj";
  };

in
buildGoModule rec {
  inherit src;
  pname = "term-apply-unstable";
  version = "2022-05-13";

  sourceRoot = "${src.name}/apps/term-apply";

  vendorSha256 = "sha256-DA923aOtIvvzre6PFUwrnHwb0WMe67v3eqp0Ejm1ArI=";

  ldflags = [
    "-X github.com/nebulaworks/orion/apps/term-apply/pkg/version.Commit=${src.rev}"
    "-X github.com/nebulaworks/orion/apps/term-apply/pkg/version.BuildTime=01011970"
  ];

  meta = with lib; {
    description = "SSH Daemon for resume applicants to Nebulaworks";
    homepage = "https://github.com/orion";
    maintainers = "NWI";
    license = licenses.bsd3;
  };
}
