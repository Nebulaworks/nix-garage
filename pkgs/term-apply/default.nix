{ lib, buildGoModule, fetchFromGitHub }:

let
  src = fetchFromGitHub {
    owner = "nebulaworks";
    rev = "d446f5088690f2e824aeeca5b8bf32ad50236cb2";
    repo = "orion";
    sha256 = "sha256:0y0krlzrpgrlrm6rg2s7zims3s0g6jwqjj8r4hyp8f9p3z52liy0";
  };

in
buildGoModule rec {
  inherit src;
  pname = "term-apply-unstable";
  version = "2022-07-05";

  sourceRoot = "${src.name}/apps/term-apply";

  vendorSha256 = "sha256-OX7aXXnFLNCsux+sHzOkwxx0zBe7XwbHhWIgXRQtUYU=";

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
