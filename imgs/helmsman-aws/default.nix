{ system ? builtins.currentSystem, pkgs }:
let
  nwi = import ../../nwi.nix;
  lib = pkgs.lib;
  # Include helm-diff plugin
  thisHelm = pkgs.wrapHelm pkgs.kubernetes-helm {
    plugins = with pkgs.kubernetes-helmPlugins; [ helm-diff ];
  };
  contents = [ pkgs.coreutils pkgs.bash pkgs.cacert pkgs.helmsman pkgs.kubectl pkgs.jq pkgs.awscli thisHelm ];
in
pkgs.dockerTools.buildImage {
  inherit contents;
  name = "nebulaworks/helmsman-aws";
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
      "com.nebulaworks.packages" = lib.strings.concatStringsSep "," (lib.lists.naturalSort (lib.lists.forEach contents (x: lib.strings.getName x + ":" + lib.strings.getVersion x)));
      "org.opencontainers.image.authors" = nwi.company;
      "org.opencontainers.image.source" = nwi.source;
    };
    WorkingDir = "/";
  };
}
