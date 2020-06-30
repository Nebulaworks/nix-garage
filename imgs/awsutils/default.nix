{ system ? builtins.currentSystem }:
let
  nwi = import ../../nwi.nix;
  pkgs = import ../../pin { snapshot = "nixos-20-03_0"; };
  lib = pkgs.lib;
  contents = with pkgs; [ cacert coreutils bash jq curl awscli ];
in
pkgs.dockerTools.buildImage {
  inherit contents;
  name = "nebulaworks/awsutils";
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
    WorkingDir = "/";
  };
}
