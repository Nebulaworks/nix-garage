{ system ? builtins.currentSystem, pkgs, fetchFromGitHub }:
let
  nwi = import ../../nwi.nix;
  lib = pkgs.lib;

  contents = [ pkgs.bash pkgs.coreutils pkgs.tfsec pkgs.yamllint ];
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
