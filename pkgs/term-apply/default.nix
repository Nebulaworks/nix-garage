{ lib, buildGoModule, fetchFromGitHub }:

let
  src = fetchFromGitHub {
    owner = "nebulaworks";
    rev = "ffab245d1c0f21700bfece040f0749f797b751fc";
    repo = "orion";
    sha256 = "sha256:1zvidyhvi9hdn3jl9lb98j1gs92f44n024y08l39vzkdg52g3wcw";
  };

in
buildGoModule rec {
  inherit src;
  pname = "term-apply-unstable";
  version = "2022-06-20";

  sourceRoot = "${src.name}/apps/term-apply";

  vendorSha256 = "sha256-pZs/MQcCflfpJ820c1Genkk+kT8/2qqwS0bO8oQ3Utg=";

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
