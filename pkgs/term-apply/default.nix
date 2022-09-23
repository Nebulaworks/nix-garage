{ lib, buildGoModule, fetchFromGitHub }:

let
  src = fetchFromGitHub {
    owner = "nebulaworks";
    rev = "740f58c47881608c6db815dc99e88ad65588b0eb";
    repo = "orion";
    sha256 = "sha256:1vydx2xdifp4msnyrnwyf23nhglf98kl5igycnp40h50k2rmahry";
  };

in
buildGoModule rec {
  inherit src;
  pname = "term-apply-unstable";
  version = "2022-09-22";

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
