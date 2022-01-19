{ system ? builtins.currentSystem, pkgs, fetchFromGitHub }:
let
  nwi = import ../../nwi.nix;
  lib = pkgs.lib;

  # Locking version of tfsec to what it was in the existing GitLab CI job definitions.
  # TODO: Upgrade to the latest and remediate all new findings.
  custom-tfsec = pkgs.tfsec.overrideAttrs (oldAttrs: rec {
    version = "0.39.26";
    src = fetchFromGitHub {
      owner = "aquasecurity";
      rev = "17acbbd9e5628f6ccbe694fc5f368720fb3e4666";
      repo = "tfsec";
      sha256 = "QRquQmPOaBEiDX5EvyzMI68mvy3A06l1s1gYXxg5xNM=";
    };
  });
  contents = [ pkgs.bash pkgs.coreutils custom-tfsec pkgs.yamllint ];
in
pkgs.dockerTools.buildImage {
  inherit contents;
  name = "nebulaworks/nwi-pr-utils";
  # Doesnt matter will use the derivation
  # when publishing to registry
  tag = "latest";
  extraCommands = ''
    # make sure /tmp exists
    mkdir -m 1777 tmp
  '';
  config = {
    Env = [
      "PATH=/bin/"
    ];
    Labels = {
      "com.nebulaworks.packages" = lib.strings.concatStringsSep "," (lib.lists.naturalSort (lib.lists.forEach contents (x: lib.strings.getName x + ":" + lib.strings.getVersion x)));
      "org.opencontainers.image.authors" = nwi.company;
      "org.opencontainers.image.source" = nwi.source;
    };
  };
}
