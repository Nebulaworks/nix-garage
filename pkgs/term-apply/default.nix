{ lib, buildGoModule, fetchFromGitHub }:

let
  src = fetchFromGitHub {
    owner = "nebulaworks";
    rev = "4367a22f2ebfcfff18d51f9aa4d8018b1512cdf8";
    repo = "orion";
    sha256 = "sha256:0fbcnvhsd90v7w25288y4x10ynkdiq21v4x183v9m69dc0a9xygd";
  };

in
buildGoModule rec {
  inherit src;
  pname = "term-apply-unstable";
  version = "2022-08-08";

  sourceRoot = "${src.name}/apps/term-apply";

  vendorSha256 = "sha256-HC2fPV4397PUenIGzQJX63S5aZe8tS8rAExGfTfg/0w=";

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
