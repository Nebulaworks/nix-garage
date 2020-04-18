{ system ? builtins.currentSystem }:

let
  pkgs = import ../../pin { snapshot = "nixos-20-03_0"; };
  lib = pkgs.lib;
  mypkgs = [ pkgs.coreutils pkgs.bash pkgs.jq pkgs.curl pkgs.awscli ];
in pkgs.dockerTools.buildImage {
  name = "nebulaworks/awsutils";
  # Doesnt matter will use the derivation
  # when publishing to registry
  tag = "latest";
  contents = mypkgs;
  extraCommands = ''
      # make sure /tmp exists
      mkdir -m 1777 tmp
  '';
  config = {
    Env = [ 
      "PATH=/bin/"
    ];
    Label = { "com.nebulaworks.packages" = lib.strings.concatStringsSep "," (lib.lists.naturalSort (lib.lists.forEach mypkgs (x: lib.strings.getName x + ":" + lib.strings.getVersion x )));
    }; 
    WorkingDir = "/";
  };
}
