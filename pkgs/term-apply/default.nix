{ lib, buildGoModule, fetchFromGitHub }:

let
  src = fetchFromGitHub {
    owner = "nebulaworks";
    rev = "5d3155c53e0c262560368b269530d74e858b3be9";
    repo = "orion";
    sha256 = "sha256:0sbawwivyl0z74v0qfi08q4ryky40w2jnlib73q83nhpzf7bj79l";
  };

in
buildGoModule rec {
  inherit src;
  pname = "term-apply-unstable";
  version = "2022-03-29";

  sourceRoot = "${src.name}/apps/term-apply";

  vendorSha256 = "sha256-U+mXan5P0rRaS15dqpNDjaVg7ZZUDOHSgr/pwuYZU0I=";

  #"-X ${sourceRoot}/pkg/version.Commit=${src.rev}"
  #"-X ${sourceRoot}/pkg/version.BuildTime=01011970"
  # Having issues leveraging sourceroot will debug shortly
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
