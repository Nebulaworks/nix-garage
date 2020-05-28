{ system ? builtins.currentSystem }:

let
  nwi = import ../../nwi.nix;
  pkgs = import ../../pin { snapshot = "nixpkgs-unstable_0"; };
  lib = pkgs.lib;
  contents = [ pkgs.coreutils pkgs.bash pkgs.jq pkgs.awscli pkgs.python3];
  python = import ./requirements.nix { inherit pkgs; };
  propagatedBuildInputs = builtins.attrValues python.packages;
in pkgs.dockerTools.buildImage {
  inherit contents;
  name = "nebulaworks/hubspot-report-pdf";
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
      "HELM_PLUGINS=/share/helm/plugins/"
    ];
    Labels = {
      "com.nebulaworks.packages" = lib.strings.concatStringsSep "," (lib.lists.naturalSort (lib.lists.forEach contents (x: lib.strings.getName x + ":" + lib.strings.getVersion x )));
      "org.opencontainers.image.authors" = nwi.company;
      "org.opencontainers.image.source" = nwi.source;
    };
    WorkingDir = "/";
  };
}
