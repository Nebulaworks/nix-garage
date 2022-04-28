{ system ? builtins.currentSystem, pkgs }:
let
  nwi = import ../../nwi.nix;
  lib = pkgs.lib;
  customPython = with pkgs; python310.withPackages
    (pythonPackages: with pythonPackages; [ ansible-lint pylint pytest yamllint ]);
  contents = with pkgs; [ bash cacert coreutils curl git gnumake jq customPython ];
in
pkgs.dockerTools.buildImage {
  inherit contents;
  name = "nebulaworks/ansible-lint";
  # Doesnt matter will use the derivation
  # when publishing to registry
  tag = "latest";
  extraCommands = ''
    # make sure /tmp exists
    mkdir -m 1777 tmp
    mkdir -p usr/bin
    ln -s ${pkgs.coreutils}/bin/env usr/bin/env
  '';
  config = {
    Env = [
      "PATH=/bin/"
      "SSL_CERT_FILE=/etc/ssl/certs/ca-bundle.crt"
    ];
    Labels = {
      "com.nebulaworks.packages" = lib.strings.concatStringsSep "," (lib.lists.naturalSort (lib.lists.forEach contents (x: lib.strings.getName x + ":" + lib.strings.getVersion x)));
      "org.opencontainers.image.authors" = nwi.company;
      "org.opencontainers.image.source" = nwi.source;
    };
    WorkingDir = "/";
  };
}
